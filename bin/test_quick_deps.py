#!/usr/bin/env python3
"""Regression tests for the shared quick-build timestamp check."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


HELPER = Path(__file__).with_name("quick-deps.sh").resolve()
PHASES = (
    "top", "head", "body", "topbar", "header", "navbar",
    "before-content", "after-content", "footer", "bottom",
)


class QuickDependenciesTest(unittest.TestCase):
    """Use a miniature site so timestamp checks never alter repository files."""

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root / "bin").mkdir()
        (self.root / "inc").mkdir()
        shutil.copyfile(HELPER, self.root / "bin/quick-deps.sh")
        for name in (
            "bin/md2html.sh", "bin/md2html.cfg", "bin/pandoc-wrapper.sh",
            "bin/subst.default.sh", ".top", "source.md", "page.html",
            *(f"inc/{phase}.default.html" for phase in PHASES),
            "inc/navbar.empty.html",
        ):
            (self.root / name).write_text("fixture\n")
        (self.root / "bin/md2html.cfg").write_text(
            "source.md\n\t-H\n\tnavbar=empty\n\t-o\n\tbin/subst.default.sh\n"
            "*.md\n\t-E\n\t200\n*\n\t-E\n\t201\n"
        )
        for path in self.root.rglob("*"):
            if path.is_file():
                os.utime(path, (100, 100))

    def current(self, match="source.md", source="source.md"):
        return subprocess.run(
            ["bash", "-c", '. bin/quick-deps.sh; quick_html_current page.html "$1" "$2"',
             "test", match, source],
            cwd=self.root, check=False,
        ).returncode == 0

    def test_equal_and_older_inputs_are_current(self):
        self.assertTrue(self.current())
        os.utime(self.root / "source.md", (99, 99))
        self.assertTrue(self.current())

    def test_missing_or_newer_input_requires_rebuild(self):
        os.utime(self.root / "source.md", (101, 101))
        self.assertFalse(self.current())
        (self.root / "source.md").unlink()
        self.assertFalse(self.current())

    def test_missing_output_requires_rebuild(self):
        (self.root / "page.html").unlink()
        self.assertFalse(self.current())

    def test_empty_output_requires_rebuild(self):
        (self.root / "page.html").write_text("")
        self.assertFalse(self.current())

    def test_newer_template_and_date_range_require_rebuild(self):
        os.utime(self.root / "inc/head.default.html", (101, 101))
        self.assertFalse(self.current())
        os.utime(self.root / "inc/head.default.html", (100, 100))
        (self.root / ".date-range").write_text("fixture\n")
        os.utime(self.root / ".date-range", (101, 101))
        self.assertFalse(self.current())

    def test_unselected_template_does_not_invalidate(self):
        os.utime(self.root / "inc/navbar.default.html", (101, 101))
        self.assertTrue(self.current())
        os.utime(self.root / "inc/navbar.empty.html", (101, 101))
        self.assertFalse(self.current())

    def test_year_navigation_uses_the_selected_phase(self):
        (self.root / ".top").write_text("1984\n1985\n")
        (self.root / "bin/md2html.cfg").write_text("[12][0-9][0-9][0-9]/README.md\n")
        for phase in ("first", "mid", "last"):
            (self.root / f"inc/navbar.year.{phase}.html").write_text("fixture\n")
            os.utime(self.root / f"inc/navbar.year.{phase}.html", (100, 100))
        os.utime(self.root / ".top", (100, 100))
        os.utime(self.root / "bin/md2html.cfg", (100, 100))
        os.utime(self.root / "inc/navbar.year.last.html", (101, 101))
        self.assertTrue(self.current("1984/README.md"))
        os.utime(self.root / "inc/navbar.year.first.html", (101, 101))
        self.assertFalse(self.current("1984/README.md"))

    def test_entry_navigation_tracks_the_entry_list(self):
        (self.root / ".allyear").write_text("1984/one\n1984/two\n")
        (self.root / "bin/md2html.cfg").write_text("[12][0-9][0-9][0-9]/*/README.md\n")
        for phase in ("first", "mid", "last"):
            (self.root / f"inc/navbar.{phase}.html").write_text("fixture\n")
            os.utime(self.root / f"inc/navbar.{phase}.html", (100, 100))
        os.utime(self.root / ".allyear", (100, 100))
        os.utime(self.root / "bin/md2html.cfg", (100, 100))
        self.assertTrue(self.current("1984/one/README.md"))
        os.utime(self.root / ".allyear", (101, 101))
        self.assertFalse(self.current("1984/one/README.md"))


if __name__ == "__main__":
    unittest.main()
