#!/usr/bin/env python3
"""Regression tests for quick-build prerequisites and provenance."""

import json
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
        self.env = os.environ.copy()
        clock = self.root / "clock"
        clock.mkdir()
        (clock / "date").write_text(
            '#!/bin/sh\nif [ "$1" = "+%Y" ]; then echo "$FAKE_YEAR"; '
            'else exec /bin/date "$@"; fi\n'
        )
        (clock / "date").chmod(0o755)
        self.env["PATH"] = str(clock) + os.pathsep + self.env["PATH"]
        self.env["FAKE_YEAR"] = "2026"
        self.record()

    def run_helper(self, action, match="source.md", source="source.md", options=()):
        return subprocess.run(
            ["bash", "-c", '. bin/quick-deps.sh; action="$1"; match="$2"; '
             'source="$3"; shift 3; TOOL_OPTION=("$@"); '
             'if [[ $action == record ]]; then quick_html_invalidate page.html || exit 1; fi; '
             '"quick_html_$action" page.html "$match" "$source"',
             "test", action, match, source, *options],
            cwd=self.root, env=self.env, check=False, capture_output=True,
        )

    def current(self, match="source.md", source="source.md", options=()):
        return self.run_helper("current", match, source, options).returncode == 0

    def record(self, match="source.md", options=()):
        result = self.run_helper("record", match, options=options)
        self.assertEqual(result.returncode, 0, result.stderr.decode())

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

    def test_missing_or_corrupt_record_requires_rebuild(self):
        record = self.root / ".quick-html-cache/page.html.sig"
        record.unlink()
        self.assertFalse(self.current())
        record.write_text("invalid\n")
        self.assertFalse(self.current())

    def test_options_changed_and_restored_require_rebuild(self):
        self.assertFalse(self.current(options=("-t", "custom", "-w", "https://example.org")))
        self.record(options=("-t", "custom", "-w", "https://example.org"))
        self.assertTrue(self.current(options=("-t", "custom", "-w", "https://example.org")))
        self.assertFalse(self.current())

    def test_output_replacement_requires_rebuild_even_with_old_timestamp(self):
        (self.root / "page.html").write_text("different output\n")
        os.utime(self.root / "page.html", (100, 100))
        self.assertFalse(self.current())

    def test_year_rollover_and_date_range_transitions(self):
        self.env["FAKE_YEAR"] = "2027"
        self.assertFalse(self.current())
        date_range = self.root / ".date-range"
        date_range.write_text("1984-2024\n")
        os.utime(date_range, (99, 99))
        self.record()
        self.env["FAKE_YEAR"] = "2028"
        self.assertFalse(self.current())
        self.record()
        date_range.write_text("1984-2025\n")
        os.utime(date_range, (99, 99))
        self.assertFalse(self.current())
        date_range.unlink()
        self.assertFalse(self.current())

    def test_inherited_date_range_and_empty_file_override(self):
        self.env["DATE_RANGE"] = "1984-2000"
        self.assertFalse(self.current())
        self.record()
        self.assertTrue(self.current())
        date_range = self.root / ".date-range"
        date_range.write_text("")
        os.utime(date_range, (99, 99))
        self.assertFalse(self.current())
        self.record()
        self.env["DATE_RANGE"] = "1984-2001"
        self.assertTrue(self.current())

    def test_failed_record_does_not_create_valid_record(self):
        self.run_helper("invalidate")
        (self.root / "page.html").unlink()
        self.assertNotEqual(self.run_helper("record").returncode, 0)
        self.assertFalse((self.root / ".quick-html-cache/page.html.sig").exists())

    def test_year_change_during_build_does_not_create_record(self):
        result = subprocess.run(
            ["bash", "-c", '. bin/quick-deps.sh; TOOL_OPTION=(); '
             'quick_html_invalidate page.html; export FAKE_YEAR=2027; '
             'quick_html_record page.html source.md'],
            cwd=self.root, env=self.env, capture_output=True,
        )
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.root / ".quick-html-cache/page.html.sig").exists())

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
        self.record("1984/README.md")
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
        self.record("1984/one/README.md")
        self.assertTrue(self.current("1984/one/README.md"))
        os.utime(self.root / ".allyear", (101, 101))
        self.assertFalse(self.current("1984/one/README.md"))


class QuickGeneratorTest(unittest.TestCase):
    """Compare real quick and full generation in a disposable miniature site."""

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        repo = HELPER.parent.parent
        shutil.copytree(repo / "bin", self.root / "bin")
        shutil.copytree(repo / "inc", self.root / "inc")
        (self.root / "author").mkdir()
        shutil.copyfile(repo / ".top", self.root / ".top")
        shutil.copyfile(repo / "about.md", self.root / "about.md")
        shutil.copyfile(repo / "index.md", self.root / "index.md")
        subprocess.run(["git", "init", "-q", str(self.root)], check=True)
        self.env = os.environ.copy()
        clock = self.root / "clock"
        clock.mkdir()
        (clock / "date").write_text(
            '#!/bin/sh\nif [ "$1" = "+%Y" ]; then echo "$FAKE_YEAR"; '
            'else exec /bin/date "$@"; fi\n'
        )
        (clock / "date").chmod(0o755)
        self.env["PATH"] = str(clock) + os.pathsep + self.env["PATH"]
        self.env["FAKE_YEAR"] = "2026"

    def generate(self, *args, page="about", success=True):
        result = subprocess.run(
            ["bin/gen-top-html.sh", *args, page],
            cwd=self.root, env=self.env, capture_output=True,
        )
        if success:
            self.assertEqual(result.returncode, 0, result.stderr.decode())
        else:
            self.assertNotEqual(result.returncode, 0)
        return result

    def test_quick_matches_full_across_options_and_year_rollover(self):
        output = self.root / "about.html"
        self.generate("-Q")
        original = output.read_bytes()
        timestamp = output.stat().st_mtime_ns
        self.generate("-Q")
        self.assertEqual(output.stat().st_mtime_ns, timestamp)

        options = ("-t", "custom tagline", "-w", "https://example.org")
        self.generate("-Q", *options)
        custom = output.read_bytes()
        self.assertNotEqual(custom, original)
        self.generate(*options)
        self.assertEqual(output.read_bytes(), custom)

        self.generate()
        self.assertEqual(output.read_bytes(), original)
        self.generate("-Q", *options)
        self.assertEqual(output.read_bytes(), custom)
        self.generate("-Q")
        self.assertEqual(output.read_bytes(), original)
        self.env["FAKE_YEAR"] = "2027"
        self.generate("-Q")
        rollover = output.read_bytes()
        self.assertNotEqual(rollover, original)
        self.generate()
        self.assertEqual(output.read_bytes(), rollover)

    def test_fixed_copyright_still_tracks_year_substitutions(self):
        (self.root / ".date-range").write_text("1984-2000\n")
        output = self.root / "index.html"
        self.generate("-Q", page="index")
        original = output.read_bytes()
        self.env["FAKE_YEAR"] = "2027"
        self.generate("-Q", page="index")
        rollover = output.read_bytes()
        self.assertNotEqual(rollover, original)
        self.generate(page="index")
        self.assertEqual(output.read_bytes(), rollover)

    def test_selected_page_options_leave_other_page_untouched(self):
        self.generate("-Q", page="about")
        self.generate("-Q", page="index")
        index = self.root / "index.html"
        timestamp = index.stat().st_mtime_ns
        self.generate("-Q", "-t", "changed tagline", page="about")
        self.generate("-Q", page="index")
        self.assertEqual(index.stat().st_mtime_ns, timestamp)

    def test_full_top_generation_populates_quick_record(self):
        output = self.root / "about.html"
        self.generate("-t", "custom tagline")
        self.assertTrue((self.root / ".quick-html-cache/about.html.sig").is_file())
        timestamp = output.stat().st_mtime_ns
        self.generate("-Q", "-t", "custom tagline")
        self.assertEqual(output.stat().st_mtime_ns, timestamp)
        self.generate("-Q")
        self.assertNotEqual(output.stat().st_mtime_ns, timestamp)

    def prepare_year(self):
        repo = HELPER.parent.parent
        year = self.root / "1984"
        year.mkdir()
        for name in (".year", "README.md"):
            shutil.copyfile(repo / "1984" / name, year / name)
        shutil.copyfile(repo / ".allyear", self.root / ".allyear")
        for entry in (year / ".year").read_text().splitlines():
            target = self.root / entry
            target.mkdir()
            for name in (".entry.json", ".path", "README.md"):
                shutil.copyfile(repo / entry / name, target / name)
        return year

    def test_year_outputs_rebuild_independently_and_match_full(self):
        year = self.prepare_year()
        for name in ("rules", "guidelines", "challenge"):
            (year / f"{name}.md").write_text(f"# {name.title()}\n\nFixture.\n")

        def generate_year(*args):
            result = subprocess.run(
                ["bin/gen-year-index.sh", *args, "1984"],
                cwd=self.root, env=self.env, capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr.decode())

        outputs = [year / f"{name}.html" for name in ("index", "rules", "guidelines", "challenge")]
        generate_year("-Q")
        before = [path.stat().st_mtime_ns for path in outputs]
        generate_year("-Q")
        self.assertEqual([path.stat().st_mtime_ns for path in outputs], before)
        (year / "rules.md").write_text("# Rules\n\nUpdated fixture.\n")
        generate_year("-Q")
        self.assertIn(b"Updated fixture.", outputs[1].read_bytes())
        self.assertEqual(
            [outputs[i].stat().st_mtime_ns for i in (0, 2, 3)],
            [before[i] for i in (0, 2, 3)],
        )
        generate_year("-Q", "-t", "custom tagline")
        quick = [path.read_bytes() for path in outputs]
        for path in outputs:
            path.unlink()
        generate_year("-t", "custom tagline")
        self.assertEqual([path.read_bytes() for path in outputs], quick)
        (self.root / ".quick-html-cache/1984/rules.html.sig").unlink()
        generate_year("-t", "custom tagline")
        before = [path.stat().st_mtime_ns for path in outputs]
        generate_year("-Q", "-t", "custom tagline")
        self.assertEqual([path.stat().st_mtime_ns for path in outputs], before)

    def test_full_entry_generation_populates_quick_record(self):
        self.prepare_year()
        repo = HELPER.parent.parent
        shutil.copyfile(repo / "author/Anonymous_1984.json", self.root / "author/Anonymous_1984.json")
        entry = "1984/anonymous"
        for name in ("anonymous.c", "anonymous.orig.c"):
            shutil.copyfile(repo / entry / name, self.root / entry / name)
        output = self.root / entry / "index.html"

        def generate_entry(script, *args):
            result = subprocess.run(
                [f"bin/{script}", *args, entry], cwd=self.root, env=self.env,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr.decode())

        generate_entry("readme2index.sh", "-v", "1")
        self.assertTrue((self.root / ".quick-html-cache" / entry / "index.html.sig").is_file())
        before = output.stat().st_mtime_ns
        generate_entry("quick-readme2index.sh", "-v", "1")
        self.assertEqual(output.stat().st_mtime_ns, before)
        generate_entry("readme2index.sh", "-v", "1", "-d", str(self.root))
        before = output.stat().st_mtime_ns
        generate_entry("quick-readme2index.sh", "-v", "1", "-d", str(self.root))
        self.assertEqual(output.stat().st_mtime_ns, before)
        generate_entry("quick-readme2index.sh", "-v", "1", "-t", "different tagline")
        self.assertNotEqual(output.stat().st_mtime_ns, before)

    def test_make_authors_and_location_populate_quick_records(self):
        self.prepare_year()
        repo = HELPER.parent.parent
        author = json.loads((repo / "author/Anonymous_1984.json").read_text())
        for handle in ("Anonymous_1984", "Fixture"):
            author["author_handle"] = handle
            data = json.dumps(author, indent=4).replace('": ', '" : ')
            (self.root / f"author/{handle}.json").write_text(data + "\n")
        shutil.copyfile(repo / "Makefile", self.root / "Makefile")
        (self.root / "template").mkdir()
        shutil.copyfile(repo / "template/var.mk", self.root / "template/var.mk")
        for target, output_name in (
            ("gen_authors", "authors.html"), ("quick_authors", "authors.html"),
            ("gen_location", "location.html"), ("quick_location", "location.html"),
        ):
            result = subprocess.run(
                ["/usr/bin/make", target], cwd=self.root, env=self.env, capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr.decode())
            output = self.root / output_name
            if target.startswith("gen_"):
                before = output.stat().st_mtime_ns
                self.assertTrue((self.root / f".quick-html-cache/{output_name}.sig").is_file())
            else:
                self.assertEqual(output.stat().st_mtime_ns, before)
        failing_location = self.root / "clock/location"
        failing_location.write_text("#!/bin/sh\nexit 1\n")
        failing_location.chmod(0o755)
        failed = subprocess.run(
            ["/usr/bin/make", "gen_authors"], cwd=self.root, env=self.env, capture_output=True,
        )
        self.assertNotEqual(failed.returncode, 0)
        self.assertFalse((self.root / ".quick-html-cache/authors.html.sig").exists())

    def test_full_years_and_other_generation_populate_quick_records(self):
        year = self.prepare_year()
        (self.root / ".top").write_text("1984\n")
        (year / "1984.tar.bz2").write_bytes(b"fixture")
        (year / "anonymous/details.md").write_text("# Details\n\nFixture.\n")
        for script, output in (
            ("gen-years.sh", self.root / "years.html"),
            ("gen-other-html.sh", year / "anonymous/details.html"),
        ):
            for args in ([], ["-Q"]):
                result = subprocess.run(
                    [f"bin/{script}", *args], cwd=self.root, env=self.env, capture_output=True,
                )
                self.assertEqual(result.returncode, 0, result.stderr.decode())
                if not args:
                    before = output.stat().st_mtime_ns
                    record = self.root / ".quick-html-cache" / (str(output.relative_to(self.root)) + ".sig")
                    self.assertTrue(record.is_file())
                else:
                    self.assertEqual(output.stat().st_mtime_ns, before)
        original = (self.root / "years.html").read_bytes()
        (year / "anonymous/.entry.json").unlink()
        failed = subprocess.run(
            ["bin/gen-years.sh"], cwd=self.root, env=self.env, capture_output=True,
        )
        self.assertNotEqual(failed.returncode, 0)
        self.assertFalse((self.root / ".quick-html-cache/years.html.sig").exists())
        self.assertEqual((self.root / "years.html").read_bytes(), original)

    def test_failed_years_build_never_becomes_a_cache_hit(self):
        self.prepare_year()
        (self.root / ".top").write_text("1984\n")
        for _ in range(2):
            result = subprocess.run(
                ["bin/gen-years.sh", "-Q"], cwd=self.root, env=self.env,
                capture_output=True,
            )
            self.assertNotEqual(result.returncode, 0)
            self.assertIn(b"compressed tarball", result.stderr)
            self.assertFalse((self.root / ".quick-html-cache/years.html.sig").exists())

    def test_dry_run_and_failed_generation_do_not_record(self):
        self.generate("-Q")
        record = self.root / ".quick-html-cache/about.html.sig"
        original = record.read_bytes()
        self.generate("-Q", "-n", "-t", "changed tagline")
        self.assertEqual(record.read_bytes(), original)
        self.generate("-Q", "-N", "-t", "changed tagline")
        self.assertEqual(record.read_bytes(), original)
        self.generate("-n", "-t", "changed tagline")
        self.assertEqual(record.read_bytes(), original)
        pandoc = self.root / "clock/pandoc"
        pandoc.write_text("#!/bin/sh\nexit 1\n")
        pandoc.chmod(0o755)
        self.generate("-t", "changed tagline", success=False)
        self.assertFalse(record.exists())


if __name__ == "__main__":
    unittest.main()
