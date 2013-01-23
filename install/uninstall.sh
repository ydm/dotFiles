#!/bin/bash

# TODO? :}

uninstall_bash () {
    echo qwe
}

uninstall_emacs () {
    rm -f ~/.emacs
}

uninstall_git () {
    git config --global --unset alias.st
    git config --global --unset color.branch
    git config --global --unset color.diff
    git config --global --unset color.status
    git config --global --unset core.editor
    git config --global --unset user.email
    git config --global --unset user.name

    rm -f ~/.global_ignore
    git config --global --unset core.excludesfile
}

# TODO
rm ~/.Xresources
rm ~/.lesspipe
rm ~/.xinitrc
rm ~/.xmonad

uninstall_emacs
