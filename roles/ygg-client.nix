{config, pkgs, ...}:
{
  services.yggdrasil = {
    enable = true;
    persistentKeys = false;

    settings = {
      Peers = [
        "tls://ygg.jjoly.dev:3443"
        "quic://129.80.167.244:23165"
        "ws://mn.us.ygg.triplebit.org:9010"
      ];
    };
  };
}

