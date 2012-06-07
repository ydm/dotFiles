# This makefile is currently responsible for two things: first, to
# install my configuration and second, to uninstall it. Install
# creates links, sets up the global ignore list for git and downloads
# Emacs configuration files and plugins, while uninstall gets rid of
# everything that's being created by install.

# Dependencies: git

# install actions:
#	1) make links and map wannabin/* to bin/*
#	TODO: learn bash and create a script for this :)
#	2) git config (user / aliases / colors / editor)
#	3) setup global git ignore
#	4) get haskell-mode and yasnippet (plugins for Emacs)
#	TODO: check if the ~/bin dir exists and create it if not
#	TODO: -ln -s -T `pwd`/xmonad ~/.xmonad
install:
	-ln -s -T `pwd`/.emacs ~/.emacs
	-ln -s -T `pwd`/emacs ~/emacs
	-ln -s -T `pwd`/wannabin/elisplint ~/bin/elisplint
	-ln -s -T `pwd`/wannabin/jslint-browser ~/bin/jslint-browser
	-ln -s -T `pwd`/wannabin/switchxkbmap ~/bin/switchxkbmap
	-git config --global alias.st "status -s"
	-git config --global color.branch auto
	-git config --global color.diff auto
	-git config --global color.status auto
	-git config --global core.editor "emacs"
	-git config --global user.email "yordan@4web.bg"
	-git config --global user.name "Йордан Миладинов"
	-cp ./Emacs.gitignore ~/.global_ignore
	-git config --global core.excludesfile ~/.global_ignore
	-git clone https://github.com/haskell/haskell-mode.git ./emacs/plugins/haskell-mode
	-git clone https://github.com/emacsmirror/yasnippet.git ./emacs/plugins/yasnippet

# note: uninstall doesn't delete the emacs/plugins/* directories
# created by install
uninstall:
	-rm -f ~/.emacs
	-rm -fr ~/emacs
	-git config --global --unset alias.st
	-git config --global --unset color.branch
	-git config --global --unset color.diff
	-git config --global --unset color.status
	-git config --global --unset core.editor
	-git config --global --unset user.email
	-git config --global --unset user.name
	-rm -f ~/.global_ignore
	-git config --global --unset core.excludesfile

uninstall-emacs-plugins:
	-rm -fr ./emacs/plugins/haskell-mode
	-rm -fr ./emacs/plugins/yasnippet

.PHONY: install
.PHONY: uninstall
.PHONY: uninstall-emacs-plugins
