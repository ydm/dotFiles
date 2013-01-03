#!/bin/bash

dot_dir=$HOME/dotFiles
bash_dir=$dot_dir/bash
emacs_dir=$dot_dir/emacs
git_dir=$dot_dir/git
xmonad_dir=$dot_dir/xmonad

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
    msg_done
}

install_emacs () {
    msg_installing 'emacs'
    ln -s -T $emacs_dir/.emacs $HOME/.emacs
    msg_done
}

install_git () {
    msg_installing 'git'
    git config --global alias.st 'status -s'
    git config --global color.branch auto
    git config --global color.diff auto
    git config --global color.status auto
    git config --global core.editor 'emacs'
    git config --global user.email 'yordan@4web.bg'
    git config --global user.name 'Yordan Miladinov'

    cp $git_dir/Emacs.gitignore $HOME/.global_gitignore
    msg_done
}

install_xmonad () {
    ln -s -T $xmonad_dir $HOME/.xmonad
}

install_bash
install_emacs
install_git
install_xmonad
