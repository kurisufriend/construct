{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rclone ];
  environment.etc."rclone-mnt.conf".text = ''
    [luug]
    type = sftp
    host = acidburn.vtluug.org
    user = rsk
    key_file = /home/rsk/.ssh/id_ed25519
'';
  fileSystems."/mnt/luug" = {
    device = "luug:/nfs";
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
