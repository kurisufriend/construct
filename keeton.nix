{ config, pkgs, ... }:

{
  imports =
    [
      ./hw/keeton.nix
      ./ho-manager.nix
    ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
 }
