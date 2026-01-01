{ config, pkgs, lib, ... }:
{
  # :)

  networking.hostName = "regent";
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
  boot.initrd.availableKernelModules = [ "tpm_tis" "tpm_crb" ];
  boot.initrd.luks.devices."cryptroot".crypttabExtraOpts = [ "tpm2-device=auto" ];
}
