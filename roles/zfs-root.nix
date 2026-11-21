{ name, host }:
{ lib, ... }:
let
  hibernate = host.swap == "hibernate";
  uefi = host.style == "uefi";
  partition = suffix: "/dev/disk/by-partlabel/${name}-${suffix}";
  unlock = suffix: {
    device = partition suffix;
    crypttabExtraOpts = lib.optional (host.fde == "tpm") "tpm2-device=auto";
  };
in {
  networking.hostId = lib.mkDefault (builtins.substring 0 8 (builtins.hashString "sha256" name));
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/mapper";
  boot.zfs.forceImportRoot = false;
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices = { cryptroot = unlock "root"; }
    // lib.optionalAttrs hibernate { cryptswap = unlock "swap"; };
  boot.resumeDevice = lib.mkIf hibernate "/dev/mapper/cryptswap";
  swapDevices = lib.optional hibernate { device = "/dev/mapper/cryptswap"; };
  boot.loader.systemd-boot.enable = uefi;
  boot.loader.efi.canTouchEfiVariables = uefi;
  boot.loader.grub = lib.mkIf (!uefi) { enable = true; device = host.install-to; };
  fileSystems = {
    "/" = { device = "${name}/root"; fsType = "zfs"; };
    "/nix" = { device = "${name}/nix"; fsType = "zfs"; neededForBoot = true; };
    "/state" = { device = "${name}/state"; fsType = "zfs"; neededForBoot = true; };
    "/boot" = {
      device = partition "boot";
      fsType = if uefi then "vfat" else "ext4";
      options = lib.optional uefi "umask=0077";
    };
  };
  services.zfs.autoSnapshot.enable = true;
}
