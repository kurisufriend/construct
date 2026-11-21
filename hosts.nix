let
  mkHost = {
    endpoint,
    install-to ? "/dev/sda",
    fde ? "pass",
    style ? "uefi",
    swap ? "none",
    filesystem ? "zfs"
  }: {
    inherit endpoint install-to fde style swap filesystem;
  };
in
  {
    "keeton" = mkHost {filesystem = "ext4"; endpoint = "keeton"; swap = "hibernate";};
    "armsmaster" = mkHost {filesystem = "ext4"; endpoint = "armsmaster";};
    "imp" = mkHost {filesystem = "ext4"; endpoint = "imp"; fde = "tpm";};
    "regent" = mkHost {filesystem = "ext4"; endpoint = "regent"; fde = "tpm";};
    "khepri" = mkHost {endpoint = "khepri"; install-to = "/dev/nvme0n1"; swap = "hibernate";};
    "cozen" = mkHost {filesystem = "ext4"; endpoint = "cozen"; install-to = "/dev/nvme0n1"; fde = "pass"; swap = "hibernate";};
  }
