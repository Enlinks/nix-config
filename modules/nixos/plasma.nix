{
  # Enable KDE Plasma Desktop Environment
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  # Exclude default applications
  #environment.plasma6.excludePackages = with pkgs.kedPackages; [
  #  plasma-browser-integration
  #];
}
