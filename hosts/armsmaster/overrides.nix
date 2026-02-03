{ config, pkgs, lib, ... }:
{
  # :)

  networking.hostName = "armsmaster";
  nixpkgs.config.allowUnfree = true;

  fileSystems."/" = { 
    device = lib.mkForce "/dev/disk/by-label/nixos"; 
    fsType = "ext4"; 
  };
  fileSystems."/boot" = { 
    device = lib.mkForce "/dev/disk/by-label/boot"; 
    fsType = "vfat"; 
  };

  boot.initrd.luks.devices."cryptroot" = {device = lib.mkForce "/dev/disk/by-partlabel/illegalporn";};
  
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
