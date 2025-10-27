{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "1d3yhhryvfjzil22ww3b7yf6s6yip7wccnm48kf06nrkslh3mhja";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.root.openssh.authorizedKeys = {
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbh3gdpIuefWXTHmNzQCn7gvTbwTUBJ1DGjOtTgrWj8 kurisufag1@gmail.com"
    ];
  };

  users.users.rsk = {
    isNormalUser = true;
    description = "rsk";
    hashedPassword = "$6$Bxa3dS0MNajGqfA7$hmzMLmAmtOrXfyOztZJB4nwabVLvyrwozqY71cZyDemFYKobfDMaoel4VRg7lmoFbZR7C10YB14vdKsDs6ytM1";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys = {
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbh3gdpIuefWXTHmNzQCn7gvTbwTUBJ1DGjOtTgrWj8 kurisufag1@gmail.com"
      ];
    };
  };


  home-manager.users.rsk = {config, pkgs, ...}: {
    home = {
      stateVersion = "25.05";
      file = {
        ".bashrc".source = ./cfgz/.bashrc;
        ".Xresources".source = ./cfgz/.Xresources;
        ".ssh/config".source =./cfgz/ssh_config;
        ".config/i3/config".source =./cfgz/i3-config;
        ".config/i3blocks/config".source = ./cfgz/i3blocks/config;
        ".config/i3blocks/memory".source = ./cfgz/i3blocks/memory;
        ".config/i3blocks/cpu_usage".source = ./cfgz/i3blocks/cpu_usage;
        ".config/i3blocks/iface".source = ./cfgz/i3blocks/iface;
        ".mozilla/firefox/profiles.ini".source = ./cfgz/ff/profiles.ini;
        ".mozilla/firefox/vaex616s.default/user.js".source = ./cfgz/ff/user.js;
        ".config/audacious/eq.preset".source = ./cfgz/audacious/eq.preset;
        ".config/mpv".source = ./cfgz/mpv;

        "data".source = config.lib.file.mkOutOfStoreSymlink "/mnt/cistern/nfs/home/rsk/data/";
      };
    };
  };
}
