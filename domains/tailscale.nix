{ config, pkgs, ... }:
let
  authkey = "/nixos-secret/tailscale";
in
{
  services.tailscale.enable = builtins.pathExists authkey;
  services.tailscale.authKeyFile = if builtins.pathExists authkey then authkey else null;
  systemd.services.tailscaled.after = ["NetworkManager-wait-online.service"];
}
