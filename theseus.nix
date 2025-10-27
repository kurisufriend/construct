# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./ho-manager.nix
      ./hw/theseus.nix
      ./domains/common.nix
      ./domains/sshd.nix
      ./domains/desktop.nix
#      ./domain/tailscale.nix
    ];
  networking.hostName = "theseus"; # Define your hostname.
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # Did you read the comment?

}
