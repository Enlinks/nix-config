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

  boot = {
    #initrd.kernelModules = [ "amdgpu" ];   Testing things to try and enable amdgpu driver instead of radeon
    #kernelPackages = pkgs.linuxPackages_6_1;
    #kernelParams = [ "iommu=pt" "iommu=soft" ];
    #kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" "amdgpu.dc=0" ]; "ivrs_ioapic[32]=00:14.0"
    # for Southern Islands (SI i.e. GCN 1) cards
    #kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
    # for Sea Islands (CIK i.e. GCN 2) cards "amdgpu.modeset=1" "amdgpu.dpm=1"
    #kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" "radeon.cik_support=0" "amdgpu.cik_support=1" "amdgpu.dc=1" ];
  };

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
  #nixpkgs.config.allowUnfree = true;

  #services.xserver.videoDrivers = [ "modesetting" ];

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
