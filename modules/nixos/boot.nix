{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "ipv6.disable=1" ];
  };
}
