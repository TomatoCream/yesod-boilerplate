{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865" }:

let
  inherit (nixpkgs) pkgs;
  #final01 = import ./default.nix {};
  ghc = pkgs.haskell.packages.${compiler}.ghcWithPackages (ps: with ps; [
    aeson base bytestring case-insensitive classy-prelude
    classy-prelude-conduit classy-prelude-yesod conduit containers
    data-default directory fast-logger file-embed foreign-store hjsmin
    http-client-tls http-conduit monad-control monad-logger persistent
    persistent-postgresql persistent-template safe shakespeare
    template-haskell text time unordered-containers vector wai
    wai-extra wai-logger warp yaml yesod yesod-auth yesod-core
    yesod-form yesod-static
    markdown
    yesod-text-markdown
  ]);
  systemPackages = with pkgs; [
    # add whatever system packages you want.
    binutils
    gcc
    ghc

    postgresql
    zlib
    zlib.dev
  ];
in
  pkgs.stdenv.mkDerivation {
    name = "yesod-boilerplate";
    buildInputs = [ ghc systemPackages ];
    shellHook = ''
      eval $(egrep ^export ${ghc}/bin/ghc)
    '';
}
