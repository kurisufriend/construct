{ pkgs, ... }:
let
  ubuntuBase = pkgs.dockerTools.pullImage {
    imageName = "ubuntu";
    imageDigest = "sha256:cd1dba651b3080c3686ecf4e3c4220f026b521fb76978881737d24f200828b2b";
    hash = "sha256-fohMohcp61oyyQ9KQ8vUs6ebVwxQ8HCDAUU8sh0At78=";
    finalImageName = "ubuntu";
    finalImageTag = "latest";
  };
  myImage = pkgs.dockerTools.buildLayeredImage {
    name = "ubuntu-test";
    tag = "latest";
    fromImage = ubuntuBase;
    contents = with pkgs; [
      hello
      bashInteractive
      cacert
      xterm
      firefox
    ];
    config = {
      Cmd = [ "/bin/bash" ];
    };
  };
in
{
  environment.systemPackages = [
    pkgs.xhost
    (pkgs.writeShellScriptBin "run-ubuntu-test" ''
      ${pkgs.xhost}/bin/xhost +local:podman > /dev/null
      REAL_USER=''${SUDO_USER:-$USER}
      REAL_UID=$(id -u $REAL_USER)
      PULSE_PATH="/run/user/$REAL_UID/pulse"
      ${pkgs.podman}/bin/podman run --rm -it \
        --name ubuntu-gui-test \
        --net=host \
        --env DISPLAY=$DISPLAY \
        --env XAUTHORITY=$XAUTHORITY \
        --env PULSE_SERVER=unix:$PULSE_PATH/native \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --volume $PULSE_PATH:$PULSE_PATH \
        --volume $XAUTHORITY:$XAUTHORITY \
        --device /dev/dri:/dev/dri \
        localhost/ubuntu-test:latest "$@"
    '')
  ];
  
  systemd.services.load-ubuntu-test-image = {
    description = "Load ubuntu-test nix derivation into podman";
    after = [ "podman.socket" ];
    requires = [ "podman.socket" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.podman}/bin/podman load -i ${myImage}
    '';
  };
}
