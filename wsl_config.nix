# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "garrettgr";


  # User Packages
  users.users = {
    garrettgr = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Garrett Gonzalez-Rivas";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        speedread
      ];
    };
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    zoxide
    ranger
    atuin
    starship
    tmux
    w3m
    lsd
    lshw
    neofetch
    git
    fzf
    tio
    gcc
    mtr
    alacritty
    tldr
    ranger
    bottom
    nmap
    docker
    speedtest-cli
    home-manager
  ];

  # Programs
  programs = {
    zsh.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
