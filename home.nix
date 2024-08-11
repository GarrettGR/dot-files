{ config, pkgs, ... }:

{

  home.username = "garrettgr";
  home.homeDirectory = "/home/garrettgr";

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05";

  home.packages = [

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "JetBrainsMono" "FiraCode" ]; })
    pkgs.monaspace
    pkgs.onlyoffice-bin
    pkgs.bat
    pkgs.eza
    pkgs.navi
    pkgs.steam
    # pkgs.btop
    pkgs.jdk21
    pkgs.libgcc
    pkgs.zig
    pkgs.xclip
    # pkgs.jdk11
    pkgs.nyxt
    pkgs.wireshark
    pkgs.neovim
    pkgs.fastfetch
    pkgs.vimPlugins.LazyVim
    pkgs.kdePackages.kmail
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {

    EDITOR = "nvim";

  };

  programs.git = {
    enable = true;
    userName = "Garrett Gonzalez-Rivas";
    userEmail = "emailforggr@gmail.com";
  };

  # programs.vscode = {
  #   enable=true;
  #   package=pkgs.vscode.fhs;
  # };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      share = true;
      # path =  "${config.xdg.dataHome}/zsh/history";
    };

    shellAliases = {
      c = "clear";
      l = "command ls -l";
      ls = "eza $eza_params";
      ll = "eza --all --header --long $eza_params";
      la = "eza --all $eza_params";
      lt = "eza --icons --tree --color-scale --git --level=3";
      lr = "eza --recurse --level=2 $eza_params";
      cat = "bat";
      ccat = "command cat";
      top = "btop";
      rl = "exec zsh";
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nixos-rebuild switch --upgrade";
      update-home = "home-manager switch";
    };

    localVariables = {
      eza_params = [
        "--git"
        "--icons"
        "--classify"
        "--group-directories-first"
        "--time-style=long-iso"
        "--group"
        "--color-scale"
      ];
    };

    initExtra = ''
      eval "$(atuin init zsh)"
    '';

    oh-my-zsh = {
      enable = true;

      extraConfig = ''
        ZOXIDE_CMD_OVERRIDE="cd"
      '';

      plugins = [
        "git"
        "copyclip"
        # "web-search"
        "fzf"
        "eza"
        "ripgrep"
        "starship"
        # "thefuck"
        "zoxide"
      ];
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
}
