{ lib, config, pkgs, ... }:

let
  cfg = config.superUser;
in
{
  options.superUser = {
    enable = lib.mkEnableOption "enable super user module";
    userName = lib.mkOption {
      default = "admin";
      description = "username";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "audio" "video" "tss" ];
    };
  };
}

