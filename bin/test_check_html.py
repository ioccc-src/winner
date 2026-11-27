#!/usr/bin/env python3
"""Regression tests for the check_html.sh command-line wrapper."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).with_name("check_html.sh").resolve()
BASH = shutil.which("bash")


class CheckHtmlTest(unittest.TestCase):
    """Use a fake validator so failures and invocations are reproducible."""

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / "site/bin").mkdir(parents=True)
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
            'exit "${TEST_VALIDATE_STATUS:-0}"\n'
        )
        validator.chmod(0o755)
        self.env = os.environ.copy()
        self.env["PATH"] = str(self.root / "tools") + os.pathsep + self.env["PATH"]
        self.env["TEST_RECORD"] = str(self.record)

    def run_script(self, *args, **env):
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
            ["--html", "--Werror", "--format", "gnu", "--",
             "-page.html", "file name.html"],
        )

    def test_tool_name_is_resolved_on_path(self):
        result = self.run_script("-d", "site", "-p", "vnu", "index.html")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(self.record.exists())

    def test_validation_failure_is_reported(self):
        result = self.run_script(
            "-d", "site", "index.html", TEST_VALIDATE_STATUS="1"
        )
        self.assertEqual(result.returncode, 1)
        self.assertIn("vnu", result.stderr)

    def test_version_failure_and_invalid_version_are_reported(self):
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
        for option in ("-n", "-N"):
            with self.subTest(option=option):
                result = self.run_script("-d", "site", option, "index.html")
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertFalse(self.record.exists())

    def test_invalid_verbosity_is_a_command_line_error(self):
        result = self.run_script("-v", "not-a-number", "-d", "site", "index.html")
        self.assertEqual(result.returncode, 3)
        self.assertIn("verbosity", result.stderr)

    def test_help_and_version_do_not_require_validator_dependencies(self):
        for option in ("-h", "-V"):
            with self.subTest(option=option):
                result = self.run_script(option, PATH="/usr/bin:/bin")
                self.assertEqual(result.returncode, 2, result.stderr)


if __name__ == "__main__":
    unittest.main()
