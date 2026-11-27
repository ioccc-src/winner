#!/usr/bin/env python3
"""Regression tests for local Markdown link checking.

Each test stages Markdown in a disposable Git repository and checks it through
the public wrapper, including generated-page, fragment, and ignored-link cases.
"""

import subprocess
import tempfile
import unittest
from pathlib import Path


VERSION = "1.0.0 2026-11-26"
CHECKER = Path(__file__).resolve().with_name("find-missing-links.sh")


class MissingLinksTest(unittest.TestCase):
    """Exercise the public shell entry point in a disposable Git repository."""

    def setUp(self):
        """Create tracked-source fixtures in a temporary Git repository."""
        # A separate index ensures fixtures have the same tracked-file semantics.
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        subprocess.run(["git", "init", "-q", str(self.root)], check=True)
        self.write("bin/md2html.cfg", "index.md\npublished.md\n*.md\n\t-E\n\t200\n*\n\t-E\n\t201\n")
        self.write("index.html", '<h1 id="about">About</h1><a name="space here"></a>')
        self.write("published.html", '<h1 id="target">Target</h1>')
        self.write("sub/index.html", '<h1 id="directory">Directory</h1>')
        self.write("file.c", "int main(void) { return 0; }\n")
        self.write("published.md", "# Target\n")
        self.write("docs/other.md", "# Other\n")

    def write(self, name, content):
        """Write one fixture, creating its parent directories as needed."""
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")

    def check(self, files):
        """Write and stage Markdown fixtures, then return checker status and errors."""
        for name, content in files.items():
            self.write(name, content)
        subprocess.run(["git", "add", "--", "*.md"], cwd=self.root, check=True)
        result = subprocess.run(
            [str(CHECKER), "-d", str(self.root)],
            cwd=self.root, capture_output=True, text=True,
        )
        return result.returncode, result.stderr

    def test_backend_version_does_not_require_repository(self):
        """Report the Python backend version without reading site configuration."""
        backend = CHECKER.with_name("check_local_links.py")
        result = subprocess.run(
            ["python3", str(backend), "--version"], cwd=self.root,
            capture_output=True, text=True,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertRegex(result.stdout, r"^\d+\.\d+\.\d+ \d{4}-\d{2}-\d{2}\n$")

    def test_valid_links_and_ignored_code(self):
        """Cover supported link forms and Markdown code exclusions together."""
        result, errors = self.check({
            "index.md": """# About

[same](#about) [query](?foo=1#about)
[encoded](#space%20here) [file](file.c#ignored)
[directory](sub/#directory) [directory without slash](sub#directory)
[cross](published.md#target) [external](https://example.test/missing)
[external token](%%REPO_URL%%/not-local)
[unpublished](docs/other.md#ignored) [reference][ref]

[ref]: published.md?query#target

`[ignored](missing-inline)`

    [ignored](missing-indented)

~~~
[ignored](missing-fenced)
~~~

```
[ignored](missing-backtick-fence)
```
""",
            "docs/readme.md": """# Repeat
# Repeat

[same](#repeat) [duplicate](?q#repeat-1)
[published](../published.md#target)
[unpublished](other.md#ignored)
""",
        })
        self.assertEqual(result, 0, errors)

    def test_invalid_links(self):
        """Each missing target or HTML fragment must produce a failure."""
        cases = {
            "missing file": "[bad](missing.c)",
            "missing anchor": "[bad](published.html#missing)",
            "missing anchor with query": "[bad](published.html?q#missing)",
            "missing Markdown": "[bad](missing.md#missing)",
            "missing non-html": "[bad](missing.tar.bz2)",
        }
        for name, link in cases.items():
            with self.subTest(name=name):
                result, errors = self.check({"index.md": link + "\n"})
                self.assertEqual(result, 1)
                self.assertIn("missing", errors)

    def test_unbuilt_published_target(self):
        """An existing source does not substitute for its missing HTML output."""
        (self.root / "published.html").unlink()
        result, errors = self.check({"index.md": "[bad](published.md#target)\n"})
        self.assertEqual(result, 1)
        self.assertIn("missing file: published.html", errors)

    def test_missing_unpublished_heading(self):
        """Same-page links in unpublished documents use Pandoc heading IDs."""
        result, errors = self.check({"docs/readme.md": "# Heading\n\n[bad](?q#missing)\n"})
        self.assertEqual(result, 1)
        self.assertIn("missing heading", errors)

    def test_untracked_markdown_is_not_scanned(self):
        """Untracked Markdown cannot introduce link failures."""
        result, errors = self.check({"index.md": "# About\n"})
        self.assertEqual(result, 0, errors)
        self.write("untracked.md", "[bad](missing.c)\n")
        result = subprocess.run(
            [str(CHECKER), "-d", str(self.root)],
            cwd=self.root, capture_output=True, text=True,
        )
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_relative_topdir(self):
        """A relative -d path must still identify the selected repository."""
        self.write("index.md", "# About\n")
        subprocess.run(["git", "add", "--", "*.md"], cwd=self.root, check=True)
        result = subprocess.run(
            [str(CHECKER), "-d", self.root.name],
            cwd=self.root.parent, capture_output=True, text=True,
        )
        self.assertEqual(result.returncode, 0, result.stderr)


if __name__ == "__main__":
    unittest.main()
