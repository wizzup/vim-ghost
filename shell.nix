# with import (fetchTarball {
#   url = https://github.com/nixos/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz;
# }) {};

with import <nixpkgs> {};
with pkgs;
with python3Packages;

let
    simple-websocket-server = buildPythonPackage rec {
      version = "git";
      pname = "simple-websocket-server";
      name = "${pname}-${version}";

      src = fetchFromGitHub {
        owner = "dpallot";
        repo = "simple-websocket-server";
        rev = "34e6def93502943d426fb8bb01c6901341dd4fe6";
        sha256 = "19rcpdx4vxg9is1cpyh9m9br5clyzrpb7gyfqsl0g3im04m098n5";
      };

      doCheck = false;
    };

  myPackages = p: with p; [
    neovim
    simple-websocket-server
    python-slugify

    python-language-server
  ];

  myPython = python3.withPackages myPackages;
in

mkShell {
    buildInputs = [ myPython ];
}
