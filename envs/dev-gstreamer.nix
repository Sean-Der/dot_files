{ pkgs ? import <nixpkgs> {} }:
let
  stable = import <nixos> {};
in
pkgs.mkShell {
  nativeBuildInputs = [
    stable.gst_all_1.gst-libav
    stable.gst_all_1.gst-plugins-bad
    stable.gst_all_1.gst-plugins-base
    stable.gst_all_1.gst-plugins-good
    stable.gst_all_1.gst-plugins-rs
    stable.gst_all_1.gst-plugins-ugly
    stable.gst_all_1.gst-vaapi
    stable.gst_all_1.gstreamer
    stable.libnice
    stable.glib.dev
    stable.pkg-config
  ];
}
