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

    nemo

    # apps
    firefox
    vscodium
    thunderbird
    tor-browser
    moonlight-qt
    alacritty
    surf
    audacious
    picard

    # gonna kms bro
    zoom-us
  ];
}
