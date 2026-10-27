{ lib, ... }:
{
  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "tpm_tis" "tpm_crb" ];
  boot.initrd.luks.devices.cryptroot = {
    device = lib.mkForce "/dev/disk/by-partlabel/cozen-root";
    crypttabExtraOpts = [ "tpm2-device=auto" ];
  };
  boot.initrd.luks.devices.cryptswap = {
    device = "/dev/disk/by-partlabel/cozen-swap";
    crypttabExtraOpts = [ "tpm2-device=auto" ];
  };
  boot.resumeDevice = "/dev/mapper/cryptswap";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  fileSystems."/boot".options = lib.mkForce [ "umask=0077" ];
}
