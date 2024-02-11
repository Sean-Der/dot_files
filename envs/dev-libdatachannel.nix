{ pkgs ? import <nixpkgs> {} }:
let
  unstable = import <nixos-unstable> {};
in
pkgs.mkShell {
	nativeBuildInputs = [
	 unstable.openssl
   unstable.pkg-config
   unstable.cmake
  ];
}
