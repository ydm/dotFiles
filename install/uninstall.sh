#!/bin/bash

# TODO? :}

uninstall_bash () {
    echo yeah...
}

uninstall_emacs () {
    rm -f ~/.emacs
    rm -fr ~/.emacs.d
}

uninstall_git () {
    git config --global --unset alias.st
    git config --global --unset alias.co
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
rm ~/.lessfilter
rm ~/.xinitrc
rm ~/.config/awesome

uninstall_emacs
