{ pkgs ? import <nixpkgs> {} }:
let
  unstable = import <nixos> {};
in
pkgs.mkShell {
  buildInputs = [
    unstable.openssl
    unstable.alsa-lib
    unstable.cmake
    unstable.curl
    unstable.ffmpeg
    unstable.jansson
    unstable.libGL
    unstable.libpulseaudio
    unstable.libuuid
    unstable.libv4l
    unstable.libvlc
    unstable.luajit
    unstable.nlohmann_json
    unstable.pkg-config
    unstable.python3
    unstable.qt6.qt3d
    unstable.swig4
    unstable.udev
    unstable.websocketpp
    unstable.asio
    unstable.x264
    unstable.xorg.libX11
    unstable.srt
    unstable.librist
    unstable.libva
    unstable.pciutils
    unstable.speex
    unstable.ccache
    unstable.ninja
    unstable.uthash
    unstable.qrcodegencpp
    unstable.mbedtls
  ];
}

 # cmake . -G Ninja -B build -DENABLE_VST=OFF -DENABLE_BROWSER=OFF -DENABLE_AJA=OFF -DENABLE_WAYLAND=OFF -DENABLE_PIPEWIRE=OFF -DENABLE_QSV11=OFF -DENABLE_DECKLINK=OFF -DENABLE_WEBSOCKET=OFF -DLibDataChannel_DIR=/home/sean/workspaces/libdatachannel/install/lib64/cmake/LibDataChannel -DCMAKE_INSTALL_PREFIX="${HOME}/obs-studio-portable" -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache -DENABLE_NVENC=false
 # cmake --build build -j$(nproc)
 # cmake --build build --target install -j$(nproc)


