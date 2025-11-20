{ config, pkgs, ... }:

{
  imports =
    [
      ./hw/keeton.nix
      ./ho-manager.nix
    ];


  networking.hostName = "keeton";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
 }
