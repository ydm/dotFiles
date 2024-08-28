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
mkdir -p ~/local/ext
cd ~/local/ext
git clone git@github.com:casouri/tree-sitter-module.git
cd tree-sitter-module
./batch.sh
rm dist/libtree-sitter-c-sharp.so # fuck c-sharp
```
spac -S pkgfile
spac -S multilib/lib32-gnutls
spac -S multilib/lib32-vulkan-icd-loader
spac -S multilib/lib32-libglvnd
spac -S python-protobuf
spac -S extra/vulkan-tools
spac -Ss lib32-nvidia-utils
spac -S feh

bazel

IF FIREFOX IS TOO BIG
layout.css.devPixelsPerPx=0.5

```
export GDK_DPI_SCALE=0.5
# export GDK_SCALE=0.5
```
