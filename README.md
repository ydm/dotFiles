My dotFiles
===========

These include configuration for
* X
* bash
* emacs
* xmonad
* git

###Emacs
My config is placed in emacs/ and is made up of
* _emacs
* A lot of packages
  * See /pkg
* These ELPAs
  * coffee-mode (elpa)
* TODO: [autocomplete](http://cx4a.org/software/auto-complete/)
* TODO: yasnippet

git/Emacs.gitignore is retrieved from https://github.com/github/gitignore

###TODO
Describe other configurations and dependencies: X, bash, fonts, xmonad

####To install
`$ make install # this currently overrides config files  
                #+TODO: stash/pop current config`

####To uninstall
`make uninstall`

####Dependencies
* Fonts
  * Inconsolata LGC
* Software:
  * GNU source-highlight (for colorizing in less)
  * aspell and aspell-en (Spellchecking in Emacs)
  * pylint (flymake-mode for python2)
  * xorg-xrdb (see X/xinitrc)

####TODO
* Write update script (git pull / svn co / etc. for all dependencies)
* Improve (un)install scripts