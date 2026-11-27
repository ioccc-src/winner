#!/usr/bin/env python3
"""Select local HTML inputs and run the Nu validator for check_html.sh.

The shell wrapper checks the execution environment and builds validator options.
This helper resolves the requested paths, applies exclusions, and invokes Nu in
bounded batches. In list mode it converts Nu's JSON diagnostics into one
repository-relative path per failing document.
"""

import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
from urllib.parse import unquote, urlsplit


HTML_SUFFIXES = (".html", ".htm", ".xhtml", ".xht")
VERSION = "1.0.0 2026-11-26"
# Limit both argument count and argument bytes, leaving room for other options.
BATCH_SIZE = 100
BATCH_BYTES = 64 * 1024


def inside(root, path):
    """Return a resolved path within root, rejecting paths that escape it.

    Resolving first makes the same containment check apply to symlink targets.
    """
    resolved = path.resolve()
    if not resolved.is_relative_to(root):
        raise ValueError(f"path is outside topdir: {path}")
    return resolved


def exclusions(root, name):
    """Read exact topdir-relative exclusions; a single dot disables the list.

    Blank lines and comments are ignored. Absolute paths and paths resolving
    outside the repository are errors rather than silently ignored entries.
    """
    if name == ".":
        return set()
    config = Path(name)
    if not config.is_absolute():
        config = root / config
    result = set()
    for line in config.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        path = Path(line)
        if path.is_absolute():
            raise ValueError(f"exclusion must be relative to topdir: {line}")
        result.add(inside(root, root / path))
    return result


def select_inputs(root, names, excluded, all_files):
    """Expand input names into resolved files and a separate stdin flag.

    Directory walks do not follow directory symlinks. By default only HTML-like
    suffixes are selected; all_files disables this filter. Exclusions and
    deduplication apply to resolved paths, including explicitly named files.
    """
    selected = {}
    stdin = False

    def add(path):
        """Filter, validate, and remember a file once using its resolved path."""
        if not all_files and not path.name.endswith(HTML_SUFFIXES):
            return
        resolved = inside(root, path)
        if resolved in excluded:
            return
        if not resolved.is_file():
            raise ValueError(f"not a regular file: {path}")
        if not os.access(resolved, os.R_OK):
            raise ValueError(f"file is not readable: {path}")
        # Absolute paths protect names beginning with '-' from option parsing.
        selected.setdefault(resolved, resolved.relative_to(root).as_posix())

    def walk_error(error):
        """Make directory traversal errors abort selection instead of hiding them."""
        raise error

    for name in names:
        if name == "-":
            if stdin:
                raise ValueError("stdin may only be specified once")
            stdin = True
            continue
        path = Path(name)
        if not path.is_absolute():
            path = root / path
        inside(root, path)
        if path.is_symlink() and path.is_dir():
            raise ValueError(f"directory symlink is not allowed: {name}")
        if path.is_dir():
            for directory, dirs, files in os.walk(path, followlinks=False, onerror=walk_error):
                dirs[:] = sorted(d for d in dirs if not (Path(directory) / d).is_symlink())
                for filename in sorted(files):
                    add(Path(directory) / filename)
        elif path.exists():
            add(path)
        else:
            raise ValueError(f"input does not exist: {name}")
    if not selected and not stdin:
        raise ValueError("no files or stdin selected for validation")
    return selected, stdin


def list_results(result, paths, stdin):
    """Translate a Nu JSON result to failing paths and an overall failure flag.

    The paths mapping associates resolved file paths with display names; stdin
    identifies a separate validator invocation. Diagnostics without a known
    document and malformed validator output are reported as operational errors.
    """
    try:
        report = json.loads(result.stderr)
        messages = report["messages"]
        if not isinstance(messages, list):
            raise ValueError("messages is not a list")
    except (ValueError, KeyError, TypeError) as error:
        print(f"check_html.py: ERROR: invalid vnu JSON output: {error}", file=sys.stderr)
        if result.stderr:
            print(result.stderr, file=sys.stderr, end="" if result.stderr.endswith("\n") else "\n")
        return True

    failed = set()
    operational = False
    for message in messages:
        if not isinstance(message, dict):
            print("check_html.py: ERROR: invalid vnu diagnostic", file=sys.stderr)
            operational = True
            continue
        kind = message.get("type")
        if kind not in ("error", "info", "non-document-error"):
            print(f"check_html.py: ERROR: unknown vnu diagnostic type: {kind}", file=sys.stderr)
            operational = True
            continue
        # With --Werror, Nu also exits nonzero for some plain info messages.
        if kind != "error" and not (kind == "info" and
                                    (message.get("subType") == "warning" or
                                     result.returncode == 1)):
            if kind == "non-document-error":
                print(f"check_html.py: ERROR: {message.get('message', 'vnu error')}", file=sys.stderr)
                operational = True
            continue
        # Nu reports absolute file URLs; never accept an unrelated URL as a
        # successful association with one of the files in this batch.
        url = message.get("url")
        if url:
            parsed = urlsplit(url)
            path = Path(unquote(parsed.path)).resolve()
            if parsed.scheme != "file" or path not in paths:
                print(f"check_html.py: ERROR: unexpected vnu document URL: {url}", file=sys.stderr)
                operational = True
                continue
            failed.add(paths[path])
        elif stdin:
            failed.add("-")
        else:
            print(f"check_html.py: ERROR: unassociated vnu diagnostic: {message.get('message', '')}",
                  file=sys.stderr)
            operational = True
    for path in sorted(failed):
        print(path)
    if result.returncode not in (0, 1):
        print(f"check_html.py: ERROR: vnu exited unexpectedly: {result.returncode}",
              file=sys.stderr)
        operational = True
    elif result.returncode and not failed and not operational:
        print(f"check_html.py: ERROR: vnu exited {result.returncode} without a validation diagnostic",
              file=sys.stderr)
        operational = True
    return bool(failed) or operational


def batches_for(paths):
    """Yield batches bounded by file count and encoded command-line length.

    Each item retains both the absolute input path and its display name.
    """
    batch = []
    size = 0
    for path, name in paths.items():
        length = len(os.fsencode(path)) + 1
        if batch and (len(batch) >= BATCH_SIZE or size + length > BATCH_BYTES):
            yield batch
            batch = []
            size = 0
        batch.append((path, name))
        size += length
    if batch:
        yield batch


def main():
    """Parse wrapper options, select inputs, and aggregate validator failures.

    Exit 0 means every selected document passed; exit 1 covers selection,
    validation, and validator execution or diagnostic errors. Argument parsing
    errors use argparse's exit status 2.
    """
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-V", "--version", action="version", version=VERSION)
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--validator", required=True)
    parser.add_argument("--exclude", required=True)
    parser.add_argument("--vnu-option", action="append", default=[])
    parser.add_argument("--all-files", action="store_true")
    parser.add_argument("--list", action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("inputs", nargs="+")
    args = parser.parse_args()
    root = args.root.resolve()
    try:
        excluded = exclusions(root, args.exclude)
        paths, stdin = select_inputs(root, args.inputs, excluded, args.all_files)
        if args.dry_run:
            return 0

        # Use bounded batches to avoid command-line size limits. Nu only reads
        # stdin when it is the sole input, so it must run separately.
        batches = list(batches_for(paths))
        if stdin:
            batches.append(None)
        failed = False
        for batch in batches:
            names = ["-"] if batch is None else [str(path) for path, _ in batch]
            command = [args.validator, *args.vnu_option, "--", *names]
            result = subprocess.run(command, cwd=root, check=False,
                                    capture_output=args.list, text=args.list)
            if args.list:
                if result.stdout:
                    print("check_html.py: ERROR: unexpected vnu output on stdout:", file=sys.stderr)
                    print(result.stdout, file=sys.stderr, end="")
                    failed = True
                failed |= list_results(result, dict(batch or []), batch is None)
            elif result.returncode:
                print(f"check_html.py: ERROR: vnu exited non-zero: {result.returncode}",
                      file=sys.stderr)
                failed = True
        return 1 if failed else 0
    except (OSError, ValueError) as error:
        print(f"check_html.py: ERROR: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
