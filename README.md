My dotFiles
===========

These include configuration for
* X
* awesome
* bash
* emacs
* git

##Emacs
My config is placed in emacs/ and is made up of
* _emacs
* A lot of packages
  * See /pkg
* These ELPAs
  * coffee-mode (elpa)
* TODO: [autocomplete](http://cx4a.org/software/auto-complete/), yasnippet

git/Emacs.gitignore is retrieved from https://github.com/github/gitignore

##Installation
WARNING: this currently overrides present config files

`$ make install`

`$ make uninstall`

##Dependencies
* Fonts
  * Inconsolata LGC
* Software:
  * GNU source-highlight (for colorizing in less)
  * aspell and aspell-en (Spellchecking in Emacs)
  * pyflakes
  * xorg-xrdb (see X/xinitrc)

##TODO
* Describe other configurations and dependencies: X, bash, fonts, xmonad
* Stash/pop current config files since the install scripts overrides them
* Update script (git pull / svn co / etc. for all dependencies)
