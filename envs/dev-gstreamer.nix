{ pkgs ? import <nixpkgs> {} }:
let
  unstable = import <nixos-unstable> {};
in
pkgs.mkShell {
  nativeBuildInputs = [
    unstable.gst_all_1.gst-libav
    unstable.gst_all_1.gst-plugins-bad
    unstable.gst_all_1.gst-plugins-base
    unstable.gst_all_1.gst-plugins-good
    unstable.gst_all_1.gst-plugins-rs
    unstable.gst_all_1.gst-plugins-ugly
    unstable.gst_all_1.gst-vaapi
    unstable.gst_all_1.gstreamer
    unstable.libnice
  ];
}
