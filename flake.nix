{ description = "Application packaged using poetry2nix";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.poetry2nix =
    { url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";      };

  outputs = {self, nixpkgs, flake-utils, poetry2nix}:
    let out = system:
      let
        pkgs = import nixpkgs {inherit system;};
        python = pkgs.python39;
        pythonEnv = pkgs.poetry2nix.mkPoetryEnv
          { inherit python;
            projectDir = ./.; };
      in
        { devShell = pkgs.mkShell
          { buildInputs = [pythonEnv]; }; };
    in
      with flake-utils.lib; eachSystem defaultSystems out;    }
