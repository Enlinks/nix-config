# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/boot.nix
      ../../modules/nixos/default.nix
      ../../modules/nixos/homeManager.nix
      #../../modules/nixos/hyperland.nix
      ../../modules/nixos/plasma.nix
      ../../modules/nixos/security.nix
      ../../modules/nixos/services.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/systemd.nix
      ../../modules/nixos/user.nix
      inputs.home-manager.nixosModules.default
    ];

  #boot = {
    #initrd.kernelModules = [ "amdgpu" ];
    #kernelPackages = pkgs.linuxPackages_6_1;
    #kernelParams = [ "radeon.cik_support=0" "amdgpu.cik_support=1" "amdgpu.dc=0" ];
    #kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" "amdgpu.dc=0" ];
  #};

  networking = {
    hostName = "Enlinks-Ideapad"; # Define your hostname.
    #enableIPv6 = false; # Not sure if needed https://github.com/NixOS/nixpkgs/issues/87802
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    firewall = {
      enable = true; # enable and open ports in the firewall.
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
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

  # DO NOT CHANGE, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "23.11"; # Did you read the comment?
  # system.copySystemConfiguration = true; # Copy the NixOS configuration file (/run/current-system/configuration.nix) NOT SUPPORTED WITH FLAKES!
}
