#!/usr/bin/env python3
"""Regression tests for the check_html.sh command-line wrapper.

A temporary site and fake Nu validator make file selection, command arguments,
diagnostics, and failure statuses reproducible without validating the whole site.
"""

import os
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


VERSION = "1.0.0 2026-11-26"
SCRIPT = Path(__file__).with_name("check_html.sh").resolve()
HELPER = Path(__file__).with_name("check_html.py").resolve()
BASH = shutil.which("bash")


class CheckHtmlTest(unittest.TestCase):
    """Use a fake validator so failures and invocations are reproducible."""

    def setUp(self):
        """Create a disposable site and a configurable fake Nu executable."""
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        (self.root / "site/bin").mkdir(parents=True)
        shutil.copyfile(HELPER, self.root / "site/bin/check_html.py")
        (self.root / "site/bin/exclude.cfg").write_text("")
        for name in ("index.html", "-page.html", "file name.html"):
            (self.root / "site" / name).write_text("<html></html>")
        (self.root / "tools").mkdir()
        self.record = self.root / "args"
        validator = self.root / "tools/vnu"
        validator.write_text(
            "#!/usr/bin/env bash\n"
            'if [[ $1 == --version ]]; then\n'
            '    printf "%s\\n" "${TEST_VERSION:-26.11.20 (test)}"\n'
            '    exit "${TEST_VERSION_STATUS:-0}"\n'
            "fi\n"
            'printf "%s\\n" "$@" > "$TEST_RECORD"\n'
            'if [[ -n ${TEST_JSON:-} ]]; then printf "%s\\n" "$TEST_JSON" >&2; fi\n'
            'exit "${TEST_VALIDATE_STATUS:-0}"\n'
        )
        validator.chmod(0o755)
        self.env = os.environ.copy()
        self.env["PATH"] = str(self.root / "tools") + os.pathsep + self.env["PATH"]
        self.env["TEST_RECORD"] = str(self.record)

    def run_script(self, *args, **env):
        """Run the shell wrapper with fixture paths and optional fake Nu settings."""
        return subprocess.run(
            [BASH, str(SCRIPT), *args], cwd=self.root,
            env={**self.env, **env}, text=True, capture_output=True,
        )

    def test_relative_topdir_and_tool_preserve_validator_arguments(self):
        """Resolve the tool before changing directory and preserve file names."""
        result = self.run_script(
            "-d", "site", "-p", "tools/vnu", "--", "-page.html", "file name.html"
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(
            self.record.read_text().splitlines(),
            ["--html", "--Werror", "--skip-non-html", "--format", "gnu", "--",
             str(self.root / "site/-page.html"), str(self.root / "site/file name.html")],
        )

    def test_tool_name_is_resolved_on_path(self):
        """Find a validator specified by name through the fixture PATH."""
        result = self.run_script("-d", "site", "-p", "vnu", "index.html")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(self.record.exists())

    def test_validation_failure_is_reported(self):
        """Propagate a nonzero validator result to the wrapper caller."""
        result = self.run_script(
            "-d", "site", "index.html", TEST_VALIDATE_STATUS="1"
        )
        self.assertEqual(result.returncode, 1)
        self.assertIn("vnu", result.stderr)

    def test_version_failure_and_invalid_version_are_reported(self):
        """Reject failed, malformed, or too-old validator version checks."""
        for env in (
            {"TEST_VERSION_STATUS": "1"},
            {"TEST_VERSION": "not-a-version"},
            {"TEST_VERSION": "26.11.19"},
        ):
            with self.subTest(env=env):
                result = self.run_script("-d", "site", "index.html", **env)
                self.assertEqual(result.returncode, 5, result.stderr)
                self.assertFalse(self.record.exists())

    def test_noop_and_parse_only_do_not_validate(self):
        """Ensure both no-op modes avoid invoking the validator on files."""
        for option in ("-n", "-N"):
            with self.subTest(option=option):
                result = self.run_script("-d", "site", option, "index.html")
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertFalse(self.record.exists())

    def test_invalid_verbosity_is_a_command_line_error(self):
        """Reject a nonnumeric verbosity argument before validation."""
        result = self.run_script("-v", "not-a-number", "-d", "site", "index.html")
        self.assertEqual(result.returncode, 3)
        self.assertIn("verbosity", result.stderr)

    def test_help_and_version_do_not_require_validator_dependencies(self):
        """Print help or version even if validator dependencies are absent."""
        for option in ("-h", "-V"):
            with self.subTest(option=option):
                result = self.run_script(option, PATH="/usr/bin:/bin")
                self.assertEqual(result.returncode, 2, result.stderr)

    def test_backend_version_does_not_require_validation_arguments(self):
        """Report the Python backend version without validator setup or inputs."""
        result = subprocess.run(
            ["python3", str(HELPER), "--version"], text=True, capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertRegex(result.stdout, r"^\d+\.\d+\.\d+ \d{4}-\d{2}-\d{2}\n$")

    def test_directory_filter_exclusions_and_all_files(self):
        """Check all four extensions, explicit exclusions, and -a semantics."""
        site = self.root / "site"
        (site / "nested").mkdir()
        for name in ("a.htm", "b.xhtml", "c.xht", "d.txt"):
            (site / "nested" / name).write_text("data")
        (site / "bin/exclude.cfg").write_text(
            " # a comment\n\n  nested/a.htm  \n"
        )
        result = self.run_script("-d", "site", "nested")
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.record.read_text().splitlines()
        self.assertIn(str(site / "nested/b.xhtml"), args)
        self.assertIn(str(site / "nested/c.xht"), args)
        self.assertNotIn(str(site / "nested/a.htm"), args)
        self.assertNotIn(str(site / "nested/d.txt"), args)

        result = self.run_script("-d", "site", "-a", "-e", ".", "nested/a.htm", "nested/d.txt")
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.record.read_text().splitlines()
        self.assertNotIn("--skip-non-html", args)
        self.assertIn(str(site / "nested/a.htm"), args)
        self.assertIn(str(site / "nested/d.txt"), args)
        result = self.run_script("-d", "site", "-a", "nested")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn(str(site / "nested/d.txt"), self.record.read_text().splitlines())

    def test_excluded_explicit_file_and_empty_selection_are_errors(self):
        """Report an empty selection when the only explicit file is excluded."""
        (self.root / "site/bin/exclude.cfg").write_text("index.html\n")
        result = self.run_script("-d", "site", "index.html")
        self.assertEqual(result.returncode, 1)
        self.assertIn("no files or stdin", result.stderr)
        self.assertFalse(self.record.exists())

    def test_missing_config_and_outside_input_are_errors(self):
        """Reject a missing exclusion configuration and an input outside topdir."""
        for args in (("-e", "missing.cfg", "index.html"), ("../outside.html",)):
            with self.subTest(args=args):
                result = self.run_script("-d", "site", *args)
                self.assertEqual(result.returncode, 1)
                self.assertFalse(self.record.exists())

    def test_directory_symlinks_are_not_followed(self):
        """Reject an explicit directory symlink and skip it during traversal."""
        site = self.root / "site"
        (site / "external").symlink_to(self.root, target_is_directory=True)
        result = self.run_script("-d", "site", "external")
        self.assertEqual(result.returncode, 1)
        result = self.run_script("-d", "site", ".")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertNotIn(str(site / "external"), self.record.read_text())

    def test_list_mode_reports_one_path_and_hides_validator_messages(self):
        """Deduplicate diagnostics for one file and print only its path."""
        url = (self.root / "site/index.html").as_uri()
        report = {"messages": [
            {"type": "error", "url": url, "message": "first error"},
            {"type": "info", "subType": "warning", "url": url, "message": "warning"},
        ]}
        result = self.run_script("-d", "site", "-l", "index.html",
                                 TEST_JSON=json.dumps(report), TEST_VALIDATE_STATUS="1")
        self.assertEqual(result.returncode, 1)
        self.assertEqual(result.stdout.strip(), "index.html")
        self.assertNotIn("first error", result.stderr)
        self.assertEqual(result.stderr, "")
        self.assertIn("json", self.record.read_text().splitlines())

    def test_list_mode_preserves_operational_errors(self):
        """Keep validator execution errors visible instead of listing a file."""
        report = {"messages": [{"type": "non-document-error", "message": "read failed"}]}
        result = self.run_script("-d", "site", "-l", "index.html",
                                 TEST_JSON=json.dumps(report), TEST_VALIDATE_STATUS="1")
        self.assertEqual(result.returncode, 1)
        self.assertIn("read failed", result.stderr)
        self.assertEqual(result.stdout, "")

    def test_list_mode_reports_plain_info_with_werror(self):
        """Associate plain informational diagnostics with failed documents."""
        report = {"messages": [
            {"type": "error", "url": (self.root / "site/index.html").as_uri()},
            {"type": "info", "url": (self.root / "site/file name.html").as_uri()},
        ]}
        result = self.run_script("-d", "site", "-l", "index.html", "file name.html",
                                 TEST_JSON=json.dumps(report), TEST_VALIDATE_STATUS="1")
        self.assertEqual(result.returncode, 1)
        self.assertEqual(result.stdout.splitlines(), ["file name.html", "index.html"])
        self.assertEqual(result.stderr, "")

    def test_list_mode_reports_malformed_validator_output(self):
        """Fail visibly when Nu's JSON diagnostics cannot be decoded."""
        result = self.run_script("-d", "site", "-l", "index.html",
                                 TEST_JSON="not JSON", TEST_VALIDATE_STATUS="1")
        self.assertEqual(result.returncode, 1)
        self.assertIn("invalid vnu JSON", result.stderr)

    def test_list_mode_reports_failed_validator_without_diagnostics(self):
        """Treat a failure without document diagnostics as an operational error."""
        result = self.run_script("-d", "site", "-l", "index.html",
                                 TEST_JSON='{"messages": []}', TEST_VALIDATE_STATUS="1")
        self.assertEqual(result.returncode, 1)
        self.assertIn("without a validation diagnostic", result.stderr)
        self.assertEqual(result.stdout, "")

    def test_stdin_cannot_be_requested_twice(self):
        """Reject duplicate stdin inputs before running the validator."""
        result = self.run_script("-d", "site", "-", "-")
        self.assertEqual(result.returncode, 1)
        self.assertIn("only be specified once", result.stderr)
        self.assertFalse(self.record.exists())

    @unittest.skipUnless(shutil.which("vnu"), "vnu is not installed")
    def test_real_vnu_checks_stdin_separately_from_files(self):
        """Nu ignores stdin when it is combined with file arguments."""
        (self.root / "site/index.html").write_text(
            '<!doctype html><html lang="en"><head><meta charset="utf-8">'
            "<title>Test</title></head><body><p>Valid.</p></body></html>"
        )
        result = subprocess.run(
            [BASH, str(SCRIPT), "-d", "site", "-p", shutil.which("vnu"),
             "-l", "index.html", "-"],
            cwd=self.root, env=self.env, input="<bad>\n",
            text=True, capture_output=True,
        )
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assertEqual(result.stdout.strip(), "-")
        self.assertEqual(result.stderr, "")


if __name__ == "__main__":
    unittest.main()
