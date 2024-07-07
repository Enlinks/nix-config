{ config, lib, ... }:

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
      hashedPassword = "$y$j9T$uQoeQtL11jQuD6Q3YKLmY1$wCDtXgzNvMsFJ5pN2FYj.VPs7wnlWgy4o.GhneBCZU0";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "audio" "video" "tss" ];
    };
  };
}
