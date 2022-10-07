My dotFiles
===========

These include:
- alacritty
- bash aliases
- emacs config
- some X
- sway config


## Setup
`$ ./setup` prints available commands

```bash
$ ~/dotFiles/setup
Usage: /home/y/dotFiles/setup <command>...

Commands:
   config_alacritty
   config_bash
   config_emacs
   config_git
   config_sway
   config_sway_startup
   install_fasd
   install_go_tools
   install_packages
   install_sway
   install_x
```

Some notes:
- config_git: failed last time I tried it :)
- install_sway: config's bar{} section has to be removed manually
- install_fasd: appends to .bashrc
- config_bash: appends to .bashrc

Some TODOs:
- Can I use (use-package) for (d:module)?
