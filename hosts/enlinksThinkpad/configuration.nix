# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/plasma.nix
      ./user.nix
      inputs.home-manager.nixosModules.default
      #./hyprland.nix # Hyprland nix config
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    #initrd.kernelModules = [ "amdgpu" ];
    #kernelPackages = pkgs.linuxPackages_6_1;
    #kernelParams = [ "radeon.cik_support=0" "amdgpu.cik_support=1" "amdgpu.dc=0" ];
    #kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" "amdgpu.dc=0" ];
    kernel.sysctl."net.ipv6.conf.all.disable_ipv6" = true;
  };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  #services.openssh = {
    #enable = true;
    #openFirewall = true;
  #};

  networking = {
    hostName = "Enlinks-nixos"; # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    firewall = {
      enable = true; # enable and open ports in the firewall.
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_york";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # weekly Pacific/Aucklandi18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services = {
    #acpid.enable = true; # ACPI daemon
    #auto-cpufreq = {
    #  enable = true;	# Cannot enable with Plasma
    #  settings = {
    #    battery = {
    #      governor = "powersave";
    #      turbo = "never";
    #    };
    #    charge = {
    #      governor = "performance";
    #      turbo = "auto";
    #    };
    #  };
    #};
    fstrim.enable = true; # TRIM support for SSD
    fwupd.enable = true; # fwupd daemon for firmware updates
    pipewire = {
      enable = true; # Enables pipewire for sound
      alsa = {
        enable = true;
        #support32Bit = true;
      };
      pulse.enable = true;
    };
    printing.enable = true; # Enable CUPS to print documents.
    xserver = {
      enable = true; # Enable the X11 windowing system.
      xkb.layout = "us"; # Configure keymap in X11
      #videoDrivers = [ "modesetting" ];
    };
  };

  security = {
    polkit.enable = true; # Enable Polkit
    rtkit.enable = true; # Needed for sound
    #tpm2 = {
    #  enable = true; # Enable tpm2, does not work on this device
    #  pkcs11.enable = true;
    #  tctiEnvironment.enable = true;
    #};
  };

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = false; # Disables pulseaudio since using pipewire
    bluetooth = {
      enable = true; # Enables Bluetooth
      powerOnBoot = true;
    };
    #acpilight.enable = true; # Allows backlight control
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  superUser.enable = true;
  superUser.userName = "enlinks";

  home-manager = {
    # Also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "enlinks" = import ./home.nix;
    };
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      neovim

      # Tools
      aha
      clinfo
      git
      glxinfo
      htop
      iotop
      neofetch
      nmap
      pciutils
      unzip
      vulkan-tools
      wget
      zip
      dmidecode

      kate # Terminal
      
      # Apps
      firefox
      signal-desktop
    ];
  };

  # OOM configuration
  systemd = {
    # Create a seperate slice for nix-daemon that is
    # memory-managed by the userspace systemd-oomd killer
    slices."nix-daemon".sliceConfig = {
      ManagedOOMMemoryPressure = "kill";
      ManagedOOMMemoryPressureLimit = "90%";
    };
    services."nix-daemon".serviceConfig = { 
      Slice = "nix-daemon.slice";

      # If a kernel-level OOM event does occur anyway,
      # strongly prefer killing nix-daemon child processes
      OOMScoreAdjust = 1000;
    };
  };

  system = {
    # copySystemConfiguration = true; # Copy the NixOS configuration file (/run/current-system/configuration.nix) NOT SUPPORTED WITH FLAKES!
    # DO NOT CHANGE, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    stateVersion = "23.11"; # Did you read the comment?
    #autoUpgrade = {
    #  enable = true;
    #  dates = "Mon *-*-* 00:00:00";
    #  allowReboot = true;
    #};
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ]; # Experimental-features which are needed.
      trusted-users = [ "root" "enlinks" ];
    };
    # Automatically cleans up old builds
    gc = {
      automatic = true;
      dates = "Mon *-*-* 01:00:00";
      options = "--delete-older-than 30d";
    };
    # Automatically creates syslink to duplicate files to clear space
    optimise = {
      automatic = true;
      dates = [ "Mon *-*-* 02:00:00" ];
    };
  };
}
