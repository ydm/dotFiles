#!/bin/bash

# TODO y:
# npm -g install less
# npm -g install recess

BASE="$HOME"/dotFiles


function installing {
    echo "Installing $1... "
}


# +---------+
# | Configs |
# +---------+

function install_X {
    installing "X settings"

    cp "$BASE"/X/_Xresources ~/.Xresources
    cp "$BASE"/X/_xinitrc ~/.xinitrc
}

function install_emacs {
    installing emacs

    rm ~/.emacs 2>/dev/null
    ln -s "$BASE"/emacs/_emacs ~/.emacs
}

function install_fonts {
    installing fonts

    mkdir -p ~/.fonts/Inconsolata-LGC
    cd "$BASE"/fonts/Inconsolata-LGC
    git archive HEAD | tar x -C ~/.fonts/Inconsolata-LGC
    fc-cache -vf
}

function install_git {
    installing git

    # First, unset all existing config settings
    for c in $(git config --global --list | grep -o -Pe '^[^=]*')
    do
	git config --global --unset "$c"
    done

    # Now set mine ;)
    git config --global alias.st 'status -s'
    git config --global color.branch auto
    git config --global color.diff auto
    git config --global color.status auto
    git config --global core.editor 'emacs'
    git config --global user.email 'jordanMiladinov@gmail.com'
    git config --global user.name 'Yordan Miladinov'

    # ...and copy the global gitignore that makes git happy to work
    # together with Emacs
    cp "$BASE"/git/Emacs.gitignore ~/.global_gitignore
    git config --global core.excludesfile ~/.global_gitignore
}

function install_i3 {
    installing i3

    rm ~/.i3 2>/dev/null
    ln -s -T "$BASE"/_i3 ~/.i3
}

function install_shell {
    installing "shell settings"
    cat "$BASE"/shell/path >> ~/.bashrc
    cat "$BASE"/shell/aliases >> ~/.bashrc
}

function install_all {
    install_X
    install_emacs
    install_fonts
    install_git
    install_i3
    install_shell
}

if [[ $# == 0 ]]
then
    install_all
else
    for arg in $@
    do
	install_$arg
    done
fi

# TODO: Hm, let's automatically install some packages!
# TODO: pacman -S emacs
# TODO: pacman -S urxvt-perls
