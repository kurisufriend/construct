{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
    sha256 = "1mwq9mzyw1al03z4q2ifbp6d0f0sx9f128xxazwrm62z0rcgv4na";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.rsk = {
    isNormalUser = true;
    description = "rsk";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };


  home-manager.users.rsk = {pkgs, ...}: {
    home.stateVersion = "24.11";
    home.file.".bashrc".source = ./cfgz/.bashrc;
    home.file.".Xresources".source = ./cfgz/.Xresources;
    home.file.".config/i3/config".source =./cfgz/i3-config;
    home.file.".config/i3blocks/config".source = ./cfgz/i3blocks/config;
    home.file.".config/i3blocks/memory".source = ./cfgz/i3blocks/memory;
    home.file.".config/i3blocks/cpu_usage".source = ./cfgz/i3blocks/cpu_usage;
    home.file.".config/i3blocks/iface".source = ./cfgz/i3blocks/iface;
    home.file.".mozilla/firefox/profiles.ini".source = ./cfgz/ff/profiles.ini;
    home.file.".mozilla/firefox/vaex616s.default/user.js".source = ./cfgz/ff/user.js;
    home.file.".config/audacious/eq.preset".source = ./cfgz/audacious/eq.preset;
    home.file.".config/mpv".source = ./cfgz/mpv;
    #home.file.".kube/wuvt_oldcluster".source = /nixos-secret/k8s/wuvt_oldcluster;
    #home.file.".kube/wuvt_newcluster".source = /nixos-secret/k8s/wuvt_newcluster;
  };
}
