#!/usr/bin/env python

'''
Expects ntags in $PATH.
'''

import argparse
import datetime
import hashlib
import os
import re
import subprocess
import sys

from pathlib import Path
from typing import List, Optional


ROOT = Path(__file__).parent.expanduser().resolve()


def binsearch(xs: List[str], prefix: str) -> int:
    low = 0
    high = len(xs) - 1
    # We're searching for exact matches and adding \t guarantees that
    # as it's used by ntags as a delimiter.
    if not prefix.endswith('\t'):
        prefix += '\t'
    n = len(prefix)
    while low <= high:
        mid = (low+high) // 2
        line = xs[mid]
        part = line[:n]
        if part > prefix:
            high = mid - 1
        elif part < prefix:
            low = mid + 1
        else:
            return mid
    return -(mid - 1)


class extract:
    @staticmethod
    def filename(line: str) -> str:
        try:
            a = line.index('\t') + 1
            b = line.index('\t', a)
        except ValueError:
            perror(f'line={line}')
            raise
        return line[a:b]

    @staticmethod
    def lineno(line: str) -> int:
        tagfields = extract.tagfields(line)
        match = re.search(r'lineno:(\d+)', tagfields)
        if match:
            group = match.group(1)  # IndexError
            return int(group)       # ValueError
        else:
            raise ValueError(f'no lineno tagfield found in "{tagfields}"')
        return 0

    @staticmethod
    def pattern(line: str) -> str:
        a = line.index('/^') + 2
        b = line.index('$/;\"\t', a)
        return line[a:b]

    @staticmethod
    def tag(line: str) -> str:
        b = line.index('\t')
        return line[:b]

    @staticmethod
    def tagfields(line: str) -> str:
        start = line.rindex('\t')
        return line[start:].strip()


def find(
    tagfile: Path,
    tag: str,
    current_file: Optional[Path] = None,
) -> str:
    # TODO: Filter out all taglines that have local definitions of the
    #       tag and file!=current.
    xs = findall(tagfile, tag)
    if not xs:
        return ''

    # If current_file is not provided, return the first match.
    if current_file is None:
        return xs[0]

    # Out of all matching taglines, find the one that has the longest
    # common path with current_file.
    def key(tagline):
        return len(os.path.commonpath([
            current_file,
            extract.filename(tagline),
        ]))
    zs = sorted(xs)
    return zs[0]


def findall(
    tagfile: Path,
    tag: str,
) -> List[str]:
    # TODO: I should cache this!  Memcached could be a very good
    # option.
    with open(tagfile, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    # Find a single line that contains this tag.
    mid = binsearch(lines, tag)
    # There could be more lines for the same tag.  Search for all of
    # them.  Since the tags file is sorted, we should search above and
    # below this one.
    tag = extract.tag(lines[mid])
    ans = [lines[mid]]
    # Collect lines above.
    above = mid - 1
    while above > 0 and extract.tag(lines[above]) == tag:
        ans.append(lines[above])
        above -= 1
    # Collect lines below.
    below = mid + 1
    while below < len(lines) and extract.tag(lines[below]) == tag:
        ans.append(lines[below])
        below += 1
    return ans


def generate_tags(tagfile: Path, path: Path, force: bool = True) -> None:
    if force or not tagfile.exists() or is_older_than(tagfile, hours=1):
        subprocess.check_call(['ntags', '-R', path, '-f', tagfile])


def is_older_than(filepath: Path, **kw):
    sec = os.path.getmtime(filepath)
    mod = datetime.datetime.fromtimestamp(sec)
    now = datetime.datetime.now()
    return (now - mod) > datetime.timedelta(**kw)


def parse_args() -> argparse.Namespace:
    ap = argparse.ArgumentParser(description='TODO')
    ap.add_argument(
        '--update', '-u',
        action='store_true',
        help='whether tags file should be update first'
    )
    ap.add_argument(
        '--tag', '-t',
        required=True,
        help='tag to search for'
    )
    ap.add_argument(
        '--current-file',
        default='',
        help='originating file where this tag is mentioned',
    )
    ap.add_argument(
        'root',
        nargs='?',
        default='.',
        help='project root',
    )
    ns = ap.parse_args()
    ns.root = Path(ns.root).expanduser().resolve()
    if ns.current_file is not None:
        ns.current_file = Path(ns.current_file)
    return ns


def perror(*a, **kw) -> None:
    kw.setdefault('file', sys.stderr)
    return print(*a, **kw)


def root_to_tagfile(path: str) -> Path:
    e = str(path).encode('ascii')
    x = hashlib.md5(e).hexdigest()
    p = f'/tmp/{x}.tags'
    return Path(p)


def main() -> None:
    # Input arguments.
    args = parse_args()
    tagfile = root_to_tagfile(args.root)

    # Generate tags if needed.
    generate_tags(tagfile, args.root, args.update)

    # Locate tag.
    tagline = find(tagfile, args.tag, args.current_file)
    if not tagline:
        return

    # Extract filename and pattern.
    filename = extract.filename(tagline)
    lineno = extract.lineno(tagline)

    # Output.
    print(f'{filename}:{lineno}')


if __name__ == '__main__':
    main()
