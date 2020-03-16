#!/bin/bash

ROOT="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

function install_emacs() {
    if [ ! -e ~/.emacs ] ; then
        cat >~/.emacs <<EOF
(custom-set-variables)
(custom-set-faces)
EOF
    fi
    PATH="$ROOT"/emacs/y-init.el
    echo "(load \"$PATH\")" # >> ~/.emacs
}

# TODO: This function doesn't work anymore for new Firefoxes!
#
# TODO: Is there a way to automate that?
# https://medium.com/@Aenon/firefox-hide-native-tabs-and-titlebar-f0b00bdbb88b
function install_firefox() {
    DIR="$(echo ~/.mozilla/firefox/*.default)"
    mkdir -p "$DIR"/chrome
    cp "$ROOT"/firefox/userChrome.css "$DIR"/chrome/
}

function install_packages() {
    # TODO: Install fonts, etc.
    sudo pacman -S firefox
    sudo pacman -S ttf-hack
}

if [ $# -eq 0 ] ; then
    install_emacs
    install_firefox
else
    for arg in $@ ; do
	install_$arg
    done
fi
