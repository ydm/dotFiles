#!/usr/bin/env python

import subprocess
import re


def combine(days, rains, index):
    begin = index * 4
    end = begin + 4
    return '{}:{}'.format(days[index], '/'.join(rains[begin:end]))


def main():
    body = subprocess.check_output(
        ['curl', 'wttr.in'], stderr=subprocess.DEVNULL
    ).decode('utf-8')
    loc = re.findall(r'^Weather report: (.+)', body)[0]
    days = re.findall(r'┤\s*\S+\s+(\d+)\s+\S+\s*├', body)
    rains = re.findall(r'(\d\d?)%', body)
    status = ' '.join(combine(days, rains, i) for i in range(3))
    print(loc, status)


if __name__ == '__main__':
    main()
