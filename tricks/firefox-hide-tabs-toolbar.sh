#!/bin/bash

ROOT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

cd ~/.mozilla/firefox
profile=$(grep Default= ./installs.ini | sed s/Default=//)
dest=$(pwd)/$profile/chrome

set -x
mkdir -p $dest
cp -t $dest $ROOT/userChrome.css 

# about:config: toolkit.legacyUserProfileCustomizations.stylesheets
