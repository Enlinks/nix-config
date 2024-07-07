# Enable sound.
sound.enable = true;
hardware = {
  pulseaudio.enable = false; # Disables pulseaudio since using pipewire
  bluetooth = {
    enable = true; # Enables Bluetooth
    powerOnBoot = true;
  };
};
