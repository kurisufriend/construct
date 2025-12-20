{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../roles/common.nix
      ../../roles/sshd.nix
      ../../roles/desktop.nix
      ../../roles/laptop.nix
      ../../roles/mounts.nix
      ../../roles/tailscale.nix
      ../../roles/ygg-client.nix
    ];


  networking.hostName = "keeton";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
 }
