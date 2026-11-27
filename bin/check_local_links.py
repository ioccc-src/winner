#!/usr/bin/env python3
"""Check tracked Markdown links against the local site.

Pandoc parses each tracked Markdown document so that reference links and heading
IDs follow the same Markdown semantics as site generation. Local destinations
are checked for existence and HTML fragments against generated pages; remote
URLs are deliberately ignored.
"""

import argparse
import datetime
import fnmatch
import json
import subprocess
import sys
from functools import lru_cache
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


VERSION = "1.0.0 2026-11-26"


class Anchors(HTMLParser):
    """Collect HTML IDs and legacy named anchors, decoding HTML entities."""

    def __init__(self):
        """Initialize a set for anchors found in one HTML document."""
        super().__init__(convert_charrefs=True)
        self.values = set()

    def handle_starttag(self, tag, attrs):
        """Collect every id and the legacy name attribute on anchor elements."""
        for key, value in attrs:
            if value is not None and (key == "id" or tag == "a" and key == "name"):
                self.values.add(value)

    handle_startendtag = handle_starttag


def walk(node):
    """Yield each dictionary in a Pandoc AST, recursively visiting its children.

    Code blocks and inline code contain text, not Link nodes, so links written
    as examples in code are not checked as real destinations.
    """
    if isinstance(node, dict):
        yield node
        for value in node.values():
            yield from walk(value)
    elif isinstance(node, list):
        for value in node:
            yield from walk(value)


class Checker:
    """Resolve tracked source links using the site's published-page mappings."""

    def __init__(self, root):
        """Load ordered page-mapping patterns and initialize the error count."""
        self.root = root.resolve()
        cfg = (self.root / "bin/md2html.cfg").read_text(encoding="utf-8")
        self.patterns = [
            line for line in cfg.splitlines()
            if line and not line[0].isspace() and not line.startswith("#")
        ]
        self.errors = 0

    def published(self, path):
        """Return whether a Markdown path matches a published-page rule.

        Rules are checked in configuration order; the final wildcard rules
        represent unsupported inputs rather than published pages.
        """
        name = path.relative_to(self.root).as_posix()
        for pattern in self.patterns:
            if fnmatch.fnmatchcase(name, pattern):
                return pattern not in ("*.md", "*")
        return False

    def html_path(self, path):
        """Map a Markdown source to the HTML path emitted by the generators.

        Selected directory and contest README files become index.html; other
        published Markdown files retain their basename with an HTML suffix.
        """
        name = path.relative_to(self.root).as_posix()
        special = {
            "bin/README.md", "inc/README.md", "next/README.md",
            "author/README.md", "archive/historic/README.md",
        }
        parts = path.relative_to(self.root).parts
        year_readme = (
            len(parts) in (2, 3) and len(parts[0]) == 4
            and parts[0].isdigit() and parts[0][0] in "12"
            and parts[-1] == "README.md"
        )
        if name in special or year_readme:
            return path.with_name("index.html")
        return path.with_suffix(".html")

    @lru_cache(maxsize=None)
    def document(self, path):
        """Parse one Markdown file with Pandoc and cache its JSON syntax tree."""
        result = subprocess.run(
            ["pandoc", "-f", "markdown", "-t", "json", str(path)],
            cwd=self.root, check=True, capture_output=True, text=True,
        )
        return json.loads(result.stdout)

    @lru_cache(maxsize=None)
    def html_anchors(self, path):
        """Parse and cache HTML IDs and named anchors for a target page."""
        parser = Anchors()
        parser.feed(path.read_text(encoding="utf-8"))
        parser.close()
        return parser.values

    def error(self, source, url, message):
        """Report a source-relative link error and count it for the exit status."""
        print(f"{source.relative_to(self.root)}: {url}: {message}", file=sys.stderr)
        self.errors += 1

    def check_link(self, source, url, headings):
        """Validate one local destination and, when applicable, its fragment.

        Site substitution tokens are expanded before resolving paths. Generated
        HTML is checked for published targets, while fragment-only links in
        unpublished Markdown are checked against Pandoc's heading IDs.
        External URLs and repository URL tokens are outside this check's scope.
        """
        # These tokens become GitHub URLs, not paths in the published site.
        if url.startswith(("%%REPO_URL%%", "%%REPO_TOP_URL%%")):
            return
        url = url.replace("%%DOCROOT_SLASH%%", "/")
        year = datetime.date.today().year
        url = url.replace("%%THIS_YEAR%%", str(year))
        url = url.replace("%%NEXT_YEAR%%", str(year + 1))
        url = url.replace("%%LAST_YEAR%%", str(year - 1))
        source_parts = source.relative_to(self.root).parts
        if source_parts[0].isdigit() and len(source_parts[0]) == 4:
            url = url.replace("%%YEAR%%", source_parts[0])
        parsed = urlsplit(url)
        if parsed.scheme or parsed.netloc:
            return
        fragment = unquote(parsed.fragment)
        raw_path = unquote(parsed.path)
        if not raw_path:
            if self.published(source):
                target = self.html_path(source)
            else:
                # Unpublished pages have no generated HTML to inspect.
                if fragment and fragment not in headings:
                    self.error(source, url, f"missing heading: {fragment}")
                return
        else:
            base = self.root if raw_path.startswith("/") else source.parent
            target = (base / raw_path.lstrip("/")).resolve()
            if not target.is_relative_to(self.root):
                self.error(source, url, "path is outside the repository")
                return
            if target.suffix.lower() == ".md" and self.published(target):
                target = self.html_path(target)
            elif target.is_dir() or raw_path.endswith("/"):
                target = target / "index.html"
        if not target.is_file():
            self.error(source, url, f"missing file: {target.relative_to(self.root)}")
        elif fragment and target.suffix.lower() in (".html", ".htm"):
            if fragment not in self.html_anchors(target):
                self.error(source, url, f"missing anchor: {fragment}")

    def run(self):
        """Check links in tracked Markdown and return 1 if any are invalid.

        Git supplies the source list; Pandoc provides both links and heading
        identifiers, including resolved reference-style links.
        """
        files = subprocess.run(
            ["git", "ls-files", "-z", "--", "*.md"],
            cwd=self.root, check=True, capture_output=True,
        ).stdout.split(b"\0")
        for name in files:
            if not name:
                continue
            source = self.root / name.decode("utf-8")
            doc = self.document(source)
            nodes = list(walk(doc))
            headings = {
                node["c"][1][0] for node in nodes if node.get("t") == "Header"
            }
            for node in nodes:
                if node.get("t") == "Link":
                    self.check_link(source, node["c"][2][0], headings)
        return 1 if self.errors else 0


def main():
    """Run the checker for the requested root and report operational errors."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-V", "--version", action="version", version=VERSION)
    parser.add_argument("--root", type=Path, default=Path.cwd())
    args = parser.parse_args()
    try:
        return Checker(args.root).run()
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print(f"check_local_links.py: {error}", file=sys.stderr)
        if isinstance(error, subprocess.CalledProcessError) and error.stderr:
            print(error.stderr, file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
