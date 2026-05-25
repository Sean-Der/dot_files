{ pkgs ? import <nixpkgs> {} }:

let
  opencv = pkgs.opencv4.override {
    enableGtk2 = true;
  };
in
pkgs.mkShell {
  buildInputs = [
    opencv
    pkgs.go
    pkgs.gtk2
  ];

  PKG_CONFIG_PATH = "$PKG_CONFIG_PATH:${opencv}/lib/pkgconfig";
}
