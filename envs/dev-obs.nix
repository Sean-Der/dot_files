{ pkgs ? import <nixpkgs> {} }:
let
  unstable = import <nixos-unstable> {};
  stable = import <nixos> {};
in
pkgs.mkShell {
	buildInputs = [
	 stable.openssl
   stable.alsa-lib
   stable.cmake
   stable.curl
   stable.ffmpeg
   stable.jansson
   stable.libGL
   stable.libpulseaudio
   stable.libuuid
   stable.libv4l
   stable.libvlc
   stable.luajit
   stable.nlohmann_json
   stable.pkg-config
   stable.python3
   stable.qt6.qt3d
   stable.swig4
   stable.udev
   stable.websocketpp
   stable.asio
   stable.x264
   stable.xorg.libX11
   stable.srt
   stable.librist
   stable.libva
   stable.pciutils
   stable.speex
   unstable.qrcodegencpp
   ];
 }


# CMAKE_PREFIX_PATH=~/workspaces/libdatachannel/install/
# cmake .. -DENABLE_BROWSER=OFF -DENABLE_AJA=OFF -DENABLE_WAYLAND=OFF -DENABLE_PIPEWIRE=OFF -DLINUX_PORTABLE=ON -DENABLE_QSV11=OFF
