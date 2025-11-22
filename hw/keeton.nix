{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ../domains/common.nix
      ../domains/sshd.nix
      ../domains/desktop.nix
      ../domains/laptop.nix
      ../domains/mounts.nix
      ../domains/tailscale.nix
      ../domains/ygg-client.nix
    ];

  # kernel opts
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # devices and filesystem mounts

  ## decrypt luks devices
  boot.initrd.luks.devices."illegalporn".device = "/dev/disk/by-uuid/84c46af1-50ce-4de5-a1c1-b55b263c348a";
  boot.initrd.luks.devices."swappy".device = "/dev/disk/by-uuid/d9817790-6668-49d8-be04-828bae6922b6";

  fileSystems."/" =
    { device = "/dev/mapper/illegalporn";
      fsType = "ext4";
    };


  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/swappy"; }
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
