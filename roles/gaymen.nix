{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pcsx2
    bottles
  ];
  programs.steam.enable = true;
}
