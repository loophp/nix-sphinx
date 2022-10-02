{
  description = "Nix Sphinx";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };

        sphinx = pkgs.python3.withPackages (pp: [
            pp.pyenchant
            pp.readthedocs-sphinx-ext
            pp.recommonmark
            pp.sphinx_rtd_theme
            pp.sphinxcontrib-spelling
            pp.sphinxcontrib-tikz
            pp.sphinx-autobuild
        ]);

        mkSphinx = name: pkgs.stdenv.mkDerivation {
          inherit name;

          src = self;

          buildInputs = [ sphinx ];

          installPhase = ''
            mkdir -p $out/bin
            cp -r ${sphinx}/bin/* $out/bin/
          '';
        };
      in
      {
        # nix run
        apps = {
          autobuild = flake-utils.lib.mkApp { drv = mkSphinx "sphinx-autobuild"; };
          build = flake-utils.lib.mkApp { drv = mkSphinx "sphinx-build"; };
        };

        # nix shell
        packages.default = pkgs.buildEnv {
          name = "sphinx-dev";
          paths = [ sphinx ];
        };

        # nix develop
        devShells.default = pkgs.mkShellNoCC {
          name = "sphinx-dev";
          buildInputs = [ sphinx ];
        };
      }
    );

}
