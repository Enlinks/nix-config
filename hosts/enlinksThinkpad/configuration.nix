# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/default.nix
      #../../modules/nixos/hyperland.nix
      ../../modules/nixos/plasma.nix
      inputs.home-manager.nixosModules.default
    ];

  networking = {
    hostName = "Enlinks-Thinkpad"; # Define your hostname.
    #enableIPv6 = false; # Not sure if needed https://github.com/NixOS/nixpkgs/issues/87802
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    firewall = {
      enable = true; # enable and open ports in the firewall.
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
    };
  };

  security = {
    tpm2 = {
      enable = true; # Enable tpm2, untested if it works on this PC
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt # or intel-media-sdk for QSV
    ];
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
      tpm2-tools

      kate # Terminal
      
      # Apps
      firefox
      signal-desktop
    ];
  };

  # DO NOT CHANGE, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "23.11"; # Did you read the comment?
  # system.copySystemConfiguration = true; # Copy the NixOS configuration file (/run/current-system/configuration.nix) NOT SUPPORTED WITH FLAKES!
}
