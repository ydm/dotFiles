{ pkgs, ... }: {
  home = {
    username = "d";
    homeDirectory = "/home/d";
    stateVersion = "22.05";

    packages = with pkgs; [
      alacritty
      binutils
      cascadia-code
      ctags
      emacs
      fasd
      firefox
      gcc
      gdb
      gnumake
      go_1_18
      gotestsum
      home-manager
      ispell
      nim
      nix-tree
      nodejs
      pavucontrol
      python3
      ripgrep
      silver-searcher
      xclip
      zlib                      # needed by pandas, but not installed _)_
      # nimbus
      chrony
      lsb-release
      lsof
    ];

    sessionVariables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.73";
      TERMINAL = "alacritty";
    };
  };

  programs = {
    bash = {
      bashrcExtra = "source ~/.bashrcx";
      enable = true;
      enableVteIntegration = true;
      historySize = 1048576;
    };
  };
}
