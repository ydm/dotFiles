#!/usr/bin/env python

'''
This script hides the Firefox tabs toolbar.

Hint: https://piro.sakura.ne.jp/xul/_treestyletab.html.en
'''

import re
from pathlib import Path
from configparser import ConfigParser


USER_CHROME = '''
@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");
#TabsToolbar {
    visibility: collapse !important;
}
'''.lstrip()


PREF_LEGACY = '''
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
'''.lstrip()


def create_userchrome(profile: Path):
    css: Path = profile / 'chrome' / 'userChrome.css'
    if not css.exists():
        print(f'[CSS] {profile.name}: [ ] creating userChrome.css...')
        css.parent.mkdir(parents=True, exist_ok=True)
        with open(css, 'w', encoding='ascii') as f:
            f.write(USER_CHROME)
    else:
        print(f'[CSS] {profile.name}: [+] userChrome.css already exists')


def update_pref(profile: Path):
    prefs: Path = profile / 'prefs.js'
    with open(prefs, 'r', encoding='utf-8') as f:
        lines = list(map(str.strip, f.readlines()))
    pattern = (PREF_LEGACY
               .strip()
               .replace('(', r'\(')
               .replace(')', r'\)')
               .replace('.', r'\.'))
    pred = lambda line: re.match(pattern, line)
    match = any(filter(pred, lines))
    if match:
        print(f'[PRF] {profile.name}: [+] legacyCustomization already on')
    else:
        print(f'[PRF] {profile.name}: [ ] patching preferences...')
        with open(prefs, 'a', encoding='utf-8') as f:
            f.write(PREF_LEGACY)


def main():
    # Locate profiles.ini.
    firefox = Path('~/.mozilla/firefox').expanduser()
    ini = firefox / 'profiles.ini'
    if not ini.exists():
        return print(f'file does not exist: {ini}')

    # Filter only the profile sections.
    print(f'[INI] Reading {ini}...')
    config = ConfigParser()
    config.read(ini)
    matcher = lambda s: re.match(r'Profile\d+', s)
    profiles = list(filter(matcher, config.sections()))

    # For each profile, appoint the userChrome.css file and, if it
    # doesn't exist, create it and make it hide the tabs toolbar.
    for profile in profiles:
        root = firefox / config[profile]['path']
        create_userchrome(root)
        update_pref(root)


if __name__ == '__main__':
    main()
