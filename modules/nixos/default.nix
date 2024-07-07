{
  imports =
    [
      ./boot.nix
      ./homeManager.nix
      ./security.nix
      ./services.nix
      ./sound.nix
      ./systemd.nix
      ./user.nix
    ];
  # Set your time zone.
  time.timeZone = "America/New_york";

  superUser.enable = true;
  superUser.userName = "enlinks";

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
