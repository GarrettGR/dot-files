# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Services
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      xkb.layout = "us";
      libinput.enable = true;
    };
    # Enable OpenSSH Daemon
    openssh.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  # Hardware
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload.enable = false;
        sync.enable = true;

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    bluetooth.enable = true;
  };

  # Programs
  programs = {
    hyprland = {
      enable = false;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
    waybar = {
      enable = false;
    };
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        22 
        80
        443
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.garrettgr = {
    isNormalUser = true;
    description = "Garrett Gonzalez-Rivas";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kate
      firefox
    #  thunderbird
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      w3m
      kitty
      fzf
      zoxide
      cargo
      cmake
      firefox-wayland
      gcc
      git
      hyprland
      hyprpaper
      hyprpicker
      lsd
      meson
      neofetch
      qt5.qtwayland
      qt6.qmake
      qt6.qtwayland
      ranger
      tldr
      waybar
      xwayland
    ];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_DESKTOP = "Hyprland";
    };
  };

  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "firaCode" "DroidSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
