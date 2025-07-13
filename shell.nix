{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    python3
  ];
  shellHook = ''
    alias b='gcc main.c lib/termbox2.h -o $(cat meta/bin)'
  '';

}
