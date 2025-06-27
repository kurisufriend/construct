{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ../domains/common.nix
      ../domains/desktop.nix
      ../domains/laptop.nix
      ../domains/mounts.nix
      ../domains/tailscale.nix
    ];

  # hostname
  networking.hostName = "keeton";


  # devices and filesystem mounts
  boot.initrd.luks.devices."luks-82a99c3e-cb76-4587-9cb9-008f8a682c73".device = "/dev/disk/by-uuid/82a99c3e-cb76-4587-9cb9-008f8a682c73";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/dd271d82-8bf9-44c2-9bf6-773c21a45a6b";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-1a86c1ea-4134-4d73-8256-2f766b3d897d".device = "/dev/disk/by-uuid/1a86c1ea-4134-4d73-8256-2f766b3d897d";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6AF6-5C01";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a3ba043a-e386-4ab0-973f-3e884fbb1405"; }
    ];

  # cpu
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;


  # hw accel
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      vaapiIntel
    ];
  };
}
