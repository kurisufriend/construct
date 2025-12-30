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
    "keeton" = mkHost {endpoint = "keeton"; swap = "hibernate"};
    "theseus" = mkHost {endpoint = "theseus"; style = "bios";};
    "imp" = mkHost {endpoint = "imp"; fde = "tpm";};
    "regent" = mkHost {endpoint = "regent"; fde = "tpm";};
  }
