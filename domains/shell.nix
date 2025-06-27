{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
  ];
  shellHook = ''
    alias b='sudo nixos-rebuild switch'
  '';

}
