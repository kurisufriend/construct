let
  mkHost = {
    endpoint,
    install-to ? "/dev/sda",
    fde ? "pass",
    style ? "uefi",
    swap ? "none"
  }: {
    inherit endpoint install-to fde style;
  };
in
  {
    "keeton" = mkHost {endpoint = "keeton"; swap = "hibernate";};
    "armsmaster" = mkHost {endpoint = "armsmaster";};
    "imp" = mkHost {endpoint = "imp"; fde = "tpm";};
    "regent" = mkHost {endpoint = "regent"; fde = "tpm";};
  }
