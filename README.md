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

Install
[tree-sitter-module](https://github.com/casouri/tree-sitter-module)
and compile all language modules:

```
mkdir -p ~/local/external
cd ~/local/external
git clone git@github.com:casouri/tree-sitter-module.git
cd tree-sitter-module
./batch.sh
cd dist
rm libtree-sitter-c-sharp.* # fuck c-sharp
```

If I have the fucking misfortune to have to use a MacOSX:

```
brew install cmake
brew install libtool
brew install ripgrep
```
