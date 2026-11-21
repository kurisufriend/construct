{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../roles/users.nix
    ../../roles/common.nix
    ../../roles/desktop.nix
    ../../roles/laptop.nix
    ../../roles/mounts.nix
    ../../roles/sshd.nix
    ../../roles/tailscale.nix
    ../../roles/ygg-client.nix
  ];

  networking.hostName = "khepri";
  networking.hostId = "bb28e342";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";

  services.displayManager.defaultSession = "none+i3";
  environment.systemPackages = with pkgs; [ dex xss-lock networkmanagerapplet ];
  services.pipewire.alsa.support32Bit = true;
  security.rtkit.enable = true;

  services.tailscale.authKeyFile = lib.mkForce null;
}
