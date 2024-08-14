{ config, pkgs, ... }:

{

  # Imports
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # -----

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # -----

  # Hardware
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    sensor.iio.enable = true;
    graphics = { # use 'common-cpu-intel' module in the future?
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
	vaapiIntel
	vaapiVdpau
	libvdpau-va-gl
      ];
    };
  };

  # -----

  # Services
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    desktopManager.plasma6.enable = true;
    displayManager.sddm.wayland.enable = true;
    printing.enable = true;
    openssh.enable = true;
    libinput.enable = true;
    hardware.bolt.enable = true;
    tailscale.enable = true;
  };


  # -----

  # Packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-27.3.11"
      ];
    };
  };

  # User Packages
  users.users = {
    garrettgr = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Garrett Gonzalez-Rivas";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
      packages = with pkgs; [
        firefox-wayland
        kate
        speedread
        spotify
        zotero_7
        zoom-us
        zed-editor
        slack
        obsidian
        onedrive
        gitkraken
        discord
        bootstrap-studio
        bitwarden
        logseq
      ];
    };
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    zoxide
    ranger
    xclip
    atuin
    libgcc
    networkmanager-openconnect
    starship
    tmux
    w3m
    anydesk
    sqlcmd # Only for IS331
    openconnect
    lsd
    asusctl
    lshw
    neofetch
    git
    fzf
    tio
    mtr
    alacritty
    tldr
    bottom
    nmap
    speedtest-cli
    # wine
    home-manager
    waybar
  ];


  # -----

  # Programs
  programs = {
    zsh.enable = true;
    hyprland.enable = true;
    virt-manager.enable = true;
  };

  # -----

  #Networking
  networking = {
    hostName = "nixos";
    # wireless.enable = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
    };
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # -----

  # Miscellaneous
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation = {
    # vmware.host.enable = true;
    libvirtd.enable = true;
    docker = {
      enable = true;
      rootless = {
          enable = true;
          setSocketVariable = true;
        };
    };
  };

  time.timeZone = "America/New_York"; # Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.rtkit.enable = true;

  system.stateVersion = "24.05";

}
