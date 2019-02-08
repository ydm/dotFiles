#!/bin/bash

ROOT="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

function install_emacs() {
    if [ ! -e ~/.emacs ] ; then
	echo '(custom-set-variables)' # > ~/.emacs
    fi
    path="$ROOT"/emacs/y-init.el
    echo "(load \"$path\")" # >> ~/.emacs
}

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
