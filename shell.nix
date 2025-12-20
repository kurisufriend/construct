{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    python3
    age
  ];
  shellHook = ''
  '';

}
