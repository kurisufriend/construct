{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # terminal utils
    htop
    mpv # not in 'desktop.nix` for audio reasons
    dig
    ripgrep # woke `find`
    git
    yubikey-manager
    age
    tmux
    mtr

    # languages
    python3

    # infra interfacing
    kubectl
    kubelogin
    kubelogin-oidc

    # local containers
    podman-compose
  ];

  # yubikey
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # tor
  services.tor.enable = true;
  services.tor.client.enable = true;
  services.tor.torsocks.enable = true;

  # local containers
  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;

  # for single-command remote deployment
  security.doas.enable = true;
  security.doas.extraRules = [
    { groups = [ "wheel" ]; noPass = false; keepEnv = true; }
  ];


  # locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
}
