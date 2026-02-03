{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix ./overrides.nix
      ../../roles/users.nix
      ../../roles/common.nix
#      ../../roles/tailscale.nix
      ../../roles/sshd.nix
      ../../roles/ygg-client.nix
      ../../roles/desktop.nix
      ../../roles/mounts.nix
      ../../roles/gaymen.nix
    ];
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11"; # Did you read the comment?

  #gfx
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
