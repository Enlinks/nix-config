{
  services = {
    xserver = {
      displayManager.sddm.wayland.enable = true; # Enable Simple Desktop Display Manager with Wayland
    };
  };

  # Font customization
  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];

  # Enable Hyprland
  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        # hidpi = true; Depricated
        enable = true;
      };
    };
    waybar.enable = true; # Status bar
    nm-applet.enable = true;
  };

  # Hyprland settings fix for menu display
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  environment = {
    systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      firefox

      dunst # Notification Daemon

      networkmanagerapplet # Networking GUI

      # hyprland related packages
      hyprland
      swww # for wallpapers
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xwayland
      wayland-protocols
      wayland-utils
      wl-clipboard
      wlroots
      meson
      kitty # Terminal
      rofi-wayland # App Launcher
      # wofi # App Launcher
    ];

    # For electron apps to use wayland
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
