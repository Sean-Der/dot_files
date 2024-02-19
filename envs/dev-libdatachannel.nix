{ pkgs ? import <nixpkgs> {} }:
let
  stable = import <nixos> {};
in
pkgs.mkShell {
	nativeBuildInputs = [
	  stable.openssl
    stable.pkg-config
    stable.cmake
    stable.ccache
    stable.ninja
  ];

  shellHook = ''
    alias cc="ccache gcc"
    export CC="ccache gcc"
    alias cxx="ccache g++"
    export CXX="ccache g++"
  '';
}

# cmake -B build -DUSE_GNUTLS=0 -DUSE_NICE=0 -DCMAKE_INSTALL_PREFIX:PATH=`pwd`/install -DCMAKE_BUILD_TYPE=Debug -G Ninja
# cmake --build build -j$(nproc)
