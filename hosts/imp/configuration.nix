{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix ./overrides.nix
      ../../roles/users.nix
      ../../roles/common.nix
      ../../roles/sshd.nix
      ../../roles/tailscale.nix
      ../../roles/ygg-client.nix
    ];
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
