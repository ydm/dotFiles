#!/usr/bin/env python3

import json
from subprocess import check_output


def kb_config(d):
    ident = d['identifier']
    s = (f'input "{ident}" {{\n'
         f'    xkb_options ctrl:nocaps\n'
         f'}}')
    return s


def touchpad_config(d):
    ident = d['identifier']
    s = (f'input "{ident}" {{\n'
         f'    tap enabled\n'
         f'}}')
    return s


def main():
    out = check_output(['swaymsg', '-t', 'get_inputs'])
    data = json.loads(out)
    for d in data:
        ident = d['identifier'].lower()
        if (d['type'] == 'keyboard'
            and ('keyboard' in ident
                 or 'kb' in ident)):
            # Or should we ask which keyboards to include and which
            # not to?
            print(kb_config(d))
        elif d['type'] == 'touchpad' and 'touchpad' in ident:
            print(touchpad_config(d))


if __name__ == '__main__':
    main()
