#!/usr/bin/env python

'''
Expects ntags in $PATH.
'''

import argparse
import datetime
import hashlib
import os
import pathlib
import re
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


class extract:
    @staticmethod
    def filename(line):
        a = line.index('\t') + 1
        b = line.index('\t', a)
        return line[a:b]

    @staticmethod
    def lineno(line):
        tagfields = extract.tagfields(line)
        matches = re.findall(r'lineno:(\d+)', tagfields)
        # Following line could throw IndexError or ValueError.
        return int(matches[0])

    @staticmethod
    def pattern(line):
        a = line.index('/^') + 2
        b = line.index('$/;\"\t', a)
        return line[a:b]

    @staticmethod
    def tagfields(line):
        start = line.rindex('\t')
        return line[start:].strip()


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
    filename = extract.filename(line)
    lineno = extract.lineno(line)

    # Output.
    print(f'{filename}:{lineno}')


if __name__ == '__main__':
    main()
