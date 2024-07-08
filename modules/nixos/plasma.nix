{
  # Enable KDE Plasma Desktop Environment
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true; # Forcing x11 due to kwin_wayland core
    };
    #xserver.desktopManager.plasma5.enable = true;
    desktopManager.plasma6.enable = true;
    #xserver.displayManager.defaultSession = "plasmax11"; # Forcing x11 due to kwin_wayland core
    #services.displayManager.defaultSession = "plasmax11"; # new method in later release
  };

  # Exclude default applications
  #environment.plasma6.excludePackages = with pkgs.kedPackages; [
  #  plasma-browser-integration
  #];
}
