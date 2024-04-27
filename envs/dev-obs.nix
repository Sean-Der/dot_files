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
    stable.ccache
    stable.ninja
    stable.uthash
    unstable.qrcodegencpp
  ];
}

 # cmake . -G Ninja -B build -DENABLE_VST=OFF -DENABLE_BROWSER=OFF -DENABLE_AJA=OFF -DENABLE_WAYLAND=OFF -DENABLE_PIPEWIRE=OFF -DLINUX_PORTABLE=ON -DENABLE_QSV11=OFF -DENABLE_DECKLINK=OFF -DENABLE_WEBSOCKET=OFF -DLibDataChannel_DIR=/home/sean/workspaces/libdatachannel/install/lib64/cmake/LibDataChannel -DCMAKE_INSTALL_PREFIX="${HOME}/obs-studio-portable" -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache -DENABLE_NATIVE_NVENC=false
 # cmake --build build -j$(nproc)
 # cmake --build build --target install -j$(nproc)


