My dotFiles
===========

These include configurations for:
- Alacritty
- Emacs
- Firefox
- Shell aliases
- X and Sway
- More


## Setup

`$ ./setup` prints available commands

```bash
$ ~/dotFiles/setup
Usage: ./setup <command>... 
 
Commands: 
   config_alacritty
   config_bash
   config_emacs
   config_firefox
   config_git
   config_go
   config_misc
   config_rust
   config_sway
   install_packages
   install_rust
   install_sway
   install_tools
   install_x
```

Some notes:
- install_sway: config's bar{} section has to be removed manually
- install_fasd: appends to .bashrc
- config_bash: appends to .bashrc


## Notes

Once the
[tree-sitter-module](https://github.com/casouri/tree-sitter-module) is
installed and all the language modules are compiled (by running
`batch.sh`), add this to the end of `~/.emacs`.

```emacs-lisp
(with-eval-after-load 'treesit
  (add-to-list 'treesit-extra-load-path
               (expand-file-name "~/local/external/tree-sitter-module/dist")))
```

Then:
```
$ cd ~/local/external/tree-sitter-module/dist
$ cp libtree-sitter-go-mod.so libtree-sitter-gomod.so
```
