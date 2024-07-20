{ config, pkgs, ... }:

{

  home.username = "garrettgr";
  home.homeDirectory = "/home/garrettgr";

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11";

  home.packages = [
    pkgs.bat
    pkgs.navi
    pkgs.jdk21
    # pkgs.jdk11
    pkgs.nyxt
    pkgs.wireshark
    pkgs.neovim
    pkgs.vimPlugins.LazyVim
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/garrettgr/etc/profile.d/hm-session-vars.sh

  home.sessionVariables = {

    EDITOR = "vim";

  };

  programs.git = {
    enable = true;
    userName = "Garrett Gonzalez-Rivas";
    userEmail = "emailforggr@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable=true;

    history = {
      size = 10000;
      share = true;
      # path =  "${config.xdg.dataHome}/zsh/history";
    };

    shellAliases = {
      c = "clear";
      l = "command ls -l";
      ls = "lsd";
      ll = "ls -l";
      la = "ls -a";
      lt = "lsd --tree";
      cat = "bat";
      rl = "exec zsh";
      # grep = "rg";
      update = "sudo nixos-rebuild switch";
      update-home = "home-manager switch";
    };

    localVariables = {
      # ZOXIDE_CMD_OVERRIDE="cd";
    };

    initExtra = ''
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(atuin init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      # theme = "robbyrussell";
      plugins = [
        "git"
        "copyfile"
        "web-search"
        "fzf"
        # "eza"
        "ripgrep"
        "starship"
        # "thefuck"
        # "zoxide"
      ];
    };

  };

  programs.home-manager.enable = true;
}
