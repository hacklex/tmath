{
  description = "Typed math book";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  inputs.flake-utils.url = "github:numtide/flake-utils/master";
  inputs.poetry2nix = {
    inputs.flake-utils.follows = "flake-utils";
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:nix-community/poetry2nix/master";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix.overlay ];
        };
        poetryOverrides = self: super: {

          # Refs https://github.com/nix-community/poetry2nix/issues/218#issuecomment-981615612
          typing-extensions = super.typing-extensions.overridePythonAttrs (
            old: {
              buildInputs = (old.buildInputs or [ ]) ++ [ self.flit-core ];
            }
          );
        };
      in rec {
        packages = flake-utils.lib.flattenTree {
          tmath-pyenv = pkgs.poetry2nix.mkPoetryEnv {
            projectDir = self;
            python = pkgs.python39;
            overrides = [
              pkgs.poetry2nix.defaultPoetryOverrides
              poetryOverrides
            ];
          };
          # tmath-html = pkgs.stdenv.mkDerivation {
          #   name = "tmath";
          #   src = self;
          #   buildInputs = [ packages.tmath-pyenv ];
          #   buildPhase = ''
          #     make html
          #   '';
          #   installPhase = ''
          #     mkdir -p $out
          #     cp -R build/html/* $out/
          #   '';
          # };
        };
        defaultPackage = packages.tmath-pyenv;
      }
    );

}
