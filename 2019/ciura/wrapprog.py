#!/usr/bin/python3

"""Reads allowed words and writes perfect pangrams composed of them.

Merges anagrams before passing them to ./prog and expands them
in ./prog's output.
"""

import collections
import subprocess
import sys


def main():
    """Wraps the execution of ./prog"""

    if len(sys.argv) < 2:
        sys.stderr.write('Usage: {} LETTERS [N]\n'.format(sys.argv[0]))
        sys.exit(2)
    anagrams = collections.defaultdict(list)
    for line in sys.stdin:
        word = line.strip()
        anagrams[''.join(sorted(word))].append(word)
    prog = subprocess.Popen(
        ['./prog'] + sys.argv[1:],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE)
    try:
        for word in anagrams:
            prog.stdin.write(bytes(word + '\n', 'utf-8'))
    except BrokenPipeError:
        sys.exit(1)
    prog.stdin.close()
    for anagram in prog.stdout:
        words = anagram.decode('utf-8').split()
        print(' '.join('/'.join(anagrams[w]) for w in words))


if __name__ == '__main__':
    main()
