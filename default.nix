{ pkgs ? import <nixpkgs> { }, mypkgs ? import <mypkgs> { }, ... }:

pkgs.stdenv.mkDerivation {
  name = "blip.kummerlaender.eu";

  src = ./.;
  LANG = "en_US.UTF-8";

  buildInputs = [
    pkgs.pandoc
    pkgs.highlight
    mypkgs.katex-wrapper
    mypkgs.make-xslt
  ];

  installPhase = ''
    make-xslt
    mkdir $out
    cp -Lr target/99_result/* $out
  '';
}
