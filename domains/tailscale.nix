{ config, pkgs, ... }:
{
  services.tailscale.enable = true;
  systemd.services.tailscaled.after = ["NetworkManager-wait-online.service"];
}
