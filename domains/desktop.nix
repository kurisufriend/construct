{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    # wm
    i3blocks
    pulseaudio

    # apps
    firefox
    thunderbird
    tor-browser
    moonlight-qt
    alacritty
    surf
    audacious
  ];
}
