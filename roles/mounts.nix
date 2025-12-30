{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rclone ];
  environment.etc."rclone-mnt.conf".text = ''
    [luug-cistern]
    type = sftp
    host = acidburn.vtluug.org
    user = rsk
    key_file = /state/home/rsk/.ssh/id_ed25519

    [rlogin]
    type = sftp
    host = rlogin.cs.vt.edu
    user = rishik
    key_file = /state/home/rsk/.ssh/id_ed25519
'';
  fileSystems."/mnt/cistern" = {
    device = "luug-cistern:/nfs/cistern";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/etc/rclone-mnt.conf"
    ];
  };
  fileSystems."/mnt/rlogin" = {
    device = "rlogin:/home/ugrads/majors/rishik";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/etc/rclone-mnt.conf"
    ];
  };
}
