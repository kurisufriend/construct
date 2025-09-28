{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rclone ];
  environment.etc."rclone-mnt.conf".text = ''
    [dirtycow]
    type = sftp
    host = dirtycow.vtluug.org
    user = rsk
    key_file = /home/rsk/.ssh/id_ed25519
'';
  fileSystems."/mnt/cistern" = {
    device = "dirtycow:/cistern";
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
