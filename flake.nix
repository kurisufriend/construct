{
  description = "kurisufriend boxen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      hostsDir = ./hosts;
      
      hostDirs = lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostsDir);
      hostNames = builtins.attrNames hostDirs;

      mkConfig = name:
        let
          confPath = hostsDir + "/${name}/configuration.nix";
          hostPath = hostsDir + "/${name}/${name}.nix";
          entryPoint = if builtins.pathExists confPath then confPath 
                      else if builtins.pathExists hostPath then hostPath
                      else throw "no cfg found for host ${name}";
        in
        lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ entryPoint ];
        };
    in {
      nixosConfigurations = lib.genAttrs hostNames mkConfig;
    };
}
