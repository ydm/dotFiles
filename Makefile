# This makefile is currently responsible for two things: first, to
# install my configuration and second, to uninstall it. Install
# creates links, sets up the global ignore list for git and downloads
# Emacs configuration files and plugins, while uninstall gets rid of
# everything that's being created by install.

# Dependencies: git

# install actions:
#	1) make links
#	2) git config (user / aliases / colors)
#	3) setup global git ignore
#	4) get haskell-mode and yasnippet (plugins for Emacs)
install:
	-ln -s -T `pwd`/.emacs ~/.emacs
	-ln -s -T `pwd`/bin ~/bin
	-ln -s -T `pwd`/emacs ~/emacs
	-git config --global user.name "Йордан Миладинов"
	-git config --global user.email "yordan@4web.bg"
	-git config --global color.diff auto
	-git config --global color.status auto
	-git config --global color.branch auto
	-git config --global --add alias.st "status -s"
	-cp ./Emacs.gitignore ~/.global_ignore
	-git config --global core.excludesfile ~/.global_ignore
	-git clone https://github.com/haskell/haskell-mode.git ./emacs/plugins/haskell-mode
	-git clone https://github.com/emacsmirror/yasnippet.git ./emacs/plugins/yasnippet

# note: uninstall doesn't delete the emacs/plugins/* directories
# created by install
uninstall:
	-rm -f ~/.emacs
	-rm -fr ~/bin
	-rm -fr ~/emacs
	-git config --global --unset user.name
	-git config --global --unset user.email
	-git config --global --unset color.diff
	-git config --global --unset color.status
	-git config --global --unset color.branch
	-git config --global --unset alias.st
	-rm -f ~/.global_ignore
	-git config --global --unset core.excludesfile
	-rm -fr ./emacs/plugins/haskell-mode
	-rm -fr ./emacs/plugins/yasnippet

.PHONY: install
.PHONY: uninstall
