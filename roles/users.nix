{ config, pkgs, ... }:
{
  # yubikey isn't non-interactive, thus not free privesc
  #  though i suppose an attacker could wait for an insert + press. something to think about
  users.users.root.openssh.authorizedKeys = {
    keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIN+Xl9xdmuWyDZaNb1haR7dLnWenrwHVPgAQBM06kbWpAAAABHNzaDo= ssh: rsk@yubikey"
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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbh3gdpIuefWXTHmNzQCn7gvTbwTUBJ1DGjOtTgrWj8 rsk@oldcountry"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID7pEQ6Kv88EKXlS6oZkhJQQQ8ZMF7j/SgVFLCK1sXdh rsk@theseus"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIN+Xl9xdmuWyDZaNb1haR7dLnWenrwHVPgAQBM06kbWpAAAABHNzaDo= ssh: rsk@yubikey"
      ];
    };
  };

}