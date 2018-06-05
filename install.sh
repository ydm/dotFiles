#!/bin/bash

ROOT="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

function install_emacs() {
    rm -f ~/.emacs.org
    [ -e ~/.emacs ] && mv ~/.emacs ~/.emacs.org
    ln -s "$ROOT"/emacs/_emacs ~/.emacs
}

function install_firefox() {
    DIR="$(echo ~/.mozilla/firefox/*.default)"
    mkdir -p "$DIR"/chrome
    cp -t "$DIR"/chrome/ "$ROOT"/firefox/userChrome.css
}

function install_packages() {
    # TODO
    # pacman -S 
}

if [ $# -eq 0 ] ; then
    install_emacs
    install_firefox
else
    for arg in $@ ; do
	install_$arg
    done
fi
