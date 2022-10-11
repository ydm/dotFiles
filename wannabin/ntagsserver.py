#!/usr/bin/env python

'''
Expects ntags in $PATH.
'''

import argparse
import datetime
import hashlib
import os
import pathlib
import subprocess
import tempfile


ROOT = pathlib.Path(__file__).parent.expanduser().resolve()


def binsearch(xs, prefix):
    low = 0
    high = len(xs) - 1
    prefix += '\t'  # We're searching for exact matches.
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
            return line
    return None


def extract_filename(line):
    a = line.index('\t') + 1
    b = line.index('\t', a)
    return line[a:b]


def extract_pattern(line):
    a = line.index('/^') + 2
    b = line.index('$/;\"\t', a)
    return line[a:b]


def find(tagsfn, tag):
    # TODO: I should cache this!
    with open(tagsfn, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    return binsearch(lines, tag)


def generate_tags(tagsfn, path, force=True):
    if force or not tagsfn.exists() or is_older_than(tagsfn, hours=1):
        subprocess.check_call(['ntags', '-R', path, '-f', tagsfn])


def is_older_than(filepath, **kw):
    sec = os.path.getmtime(filepath)
    mod = datetime.datetime.fromtimestamp(sec)
    now = datetime.datetime.now()
    return (now - mod) > datetime.timedelta(**kw)


def locate_pattern(filename, pattern):
    # Strip problematic characters.
    strip = lambda s: s.replace('\\', '')
    pattern = strip(pattern)
    with open(filename, 'r', encoding='utf-8') as f:
        for (i, line) in enumerate(f):
            line = line[:-1]    # Strip newline at end.
            line = strip(line)
            if line == pattern:
                return i
    return -1


def parse_args():
    ap = argparse.ArgumentParser(description='TODO')
    ap.add_argument('--update', '-u', action='store_true')
    ap.add_argument('--tag', '-t', required=True)
    ap.add_argument('path', nargs='?', default='.')
    return ap.parse_args()


def path_to_tagsfn(path):
    e = str(path).encode('ascii')
    x = hashlib.md5(e).hexdigest()
    p = f'/tmp/{x}.tags'
    return pathlib.Path(p)


def main():
    # Input arguments.
    args = parse_args()
    args.path = pathlib.Path(args.path).expanduser().resolve()
    tagsfn = path_to_tagsfn(args.path)

    # Generate tags if needed.
    generate_tags(tagsfn, args.path, args.update)

    # Locate tag.
    line = find(tagsfn, args.tag)
    if not line:
        return

    # Extract filename and pattern.
    filename = extract_filename(line)
    pattern = extract_pattern(line)

    # Use filename and pattern to find the precise line of the definition.
    lineno = locate_pattern(filename, pattern)

    #
    print(f'{filename}:{lineno}')


if __name__ == '__main__':
    main()
