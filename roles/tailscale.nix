{ config, pkgs, ... }:
let
  authkey = "/state/secrets/tailscale";
in
{
  services.tailscale.enable = true;
  services.tailscale.authKeyFile = authkey;
  systemd.services.tailscaled.after = ["NetworkManager-wait-online.service"];
}
