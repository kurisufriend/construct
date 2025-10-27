{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
    sha256 = "0q3lv288xlzxczh6lc5lcw0zj9qskvjw3pzsrgvdh8rl8ibyq75s";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.users.root.openssh.authorizedKeys = {
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbh3gdpIuefWXTHmNzQCn7gvTbwTUBJ1DGjOtTgrWj8 kurisufag1@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID7pEQ6Kv88EKXlS6oZkhJQQQ8ZMF7j/SgVFLCK1sXdh rsk@theseus"
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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID7pEQ6Kv88EKXlS6oZkhJQQQ8ZMF7j/SgVFLCK1sXdh rsk@theseus"
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
