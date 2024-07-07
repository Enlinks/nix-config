{
  # OOM configuration
  systemd = {
    # Create a seperate slice for nix-daemon that is
    # memory-managed by the userspace systemd-oomd killer
    slices."nix-daemon".sliceConfig = {
      ManagedOOMMemoryPressure = "kill";
      ManagedOOMMemoryPressureLimit = "90%";
    };
    services."nix-daemon".serviceConfig = {
      Slice = "nix-daemon.slice";
      # If a kernel-level OOM event does occur anyway,
      # strongly prefer killing nix-daemon child processes
      OOMScoreAdjust = 1000;
    };
  };
}
