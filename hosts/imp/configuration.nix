{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix ./overrides.nix ./overrides.nix ./overrides.nix ./overrides.nix ./overrides.nix
    ];
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
