#!/usr/bin/env python3
"""Regression tests for navbar AWK error handling."""

import subprocess
import unittest
from pathlib import Path


BIN = Path(__file__).resolve().parent


def run_awk(script, variable, data):
    """Run a navbar generator on a small in-memory manifest."""
    return subprocess.run(
        ["awk", "-v", variable, "-f", str(BIN / script)],
        input=data, text=True, capture_output=True, check=False,
    )


class NavbarTest(unittest.TestCase):
    """Malformed inputs must fail rather than emit successful navbar output."""

    def test_year_not_found_is_an_error(self):
        result = run_awk("subst.year-navbar.awk", "year_arg=2000", "1984\n1985\n")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("did not find", result.stdout)

    def test_invalid_entry_line_is_an_error_even_after_match(self):
        result = run_awk(
            "subst.entry-navbar.awk", "entry_path=1984/mullender",
            "1984/mullender\ninvalid\n",
        )
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn("navbar=last", result.stdout)

    def test_empty_entry_path_component_is_an_error(self):
        result = run_awk("subst.entry-navbar.awk", "entry_path=1984/", "1984/\n")
        self.assertEqual(result.returncode, 211)

    def test_valid_entry_navbar(self):
        result = run_awk(
            "subst.entry-navbar.awk", "entry_path=1984/mullender",
            "1984/anonymous\n1984/mullender\n1985/shapiro\n",
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("navbar=mid", result.stdout)
        self.assertIn("RIGHT_LINK=../../1985/shapiro/index.html", result.stdout)


if __name__ == "__main__":
    unittest.main()
