#!/bin/bash

# TODO y:
# npm -g install editorconfig
# npm -g install coffee-?script
# npm -g install less
# --> npm -g install recess

dot_dir=$HOME/dotFiles
bash_dir=$dot_dir/bash
emacs_dir=$dot_dir/emacs
git_dir=$dot_dir/git
X_dir=$dot_dir/X
i3_dir=$dot_dir/_i3

msg_installing () {
    echo -n "Installing settings for $1... "
}

msg_done () {
    echo 'done.'
}

install_bash () {
    msg_installing 'bash'
    echo "
# include settings from my dotFiles
source $bash_dir/source-me" >> ~/.bashrc
    ln -s -T $bash_dir/_lessfilter $HOME/.lessfilter
    msg_done
}

install_emacs () {
    msg_installing 'emacs'
    ln -s -T $emacs_dir/_emacs $HOME/.emacs
    msg_done
}

install_git () {
    msg_installing 'git'
    git config --global alias.st 'status -s'
    git config --global alias.co 'commit'
    git config --global color.branch auto
    git config --global color.diff auto
    git config --global color.status auto
    git config --global core.editor 'emacs'
    git config --global user.email 'yordan@4web.bg'
    git config --global user.name 'Yordan Miladinov'

    cp $git_dir/Emacs.gitignore $HOME/.global_gitignore
    msg_done
}

install_X () {
    msg_installing 'X'
    ln -s -T $X_dir/_Xresources ~/.Xresources
    ln -s -T $X_dir/_xinitrc ~/.xinitrc
    msg_done
}

install_i3 () {
    ln -s -T $i3_dir $HOME/.i3
}

install_all () {
    install_bash
    install_emacs
    install_git
    install_X
    install_i3
}

if [[ $# == 0 ]]
then
    install_all
else
    # TODO: Check if such procedure exists
    install_$1
fi
