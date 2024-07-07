services = {
  fstrim.enable = true; # TRIM support for SSD
  fwupd.enable = true; # fwupd daemon for firmware updates
  pipewire = {
    enable = true; # Enables pipewire for sound
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  printing.enable = true; # Enable CUPS to print documents.
  xserver = {
    enable = true; # Enable the X11 windowing system.
    xkb.layout = "us"; # Configure keymap in X11
  };
};
