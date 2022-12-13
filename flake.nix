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
        };

        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-full latexmk;
        };

        sphinx = pkgs.python3.withPackages (pp: [
            pp.pyenchant
            pp.readthedocs-sphinx-ext
            pp.recommonmark
            pp.rst2pdf
            pp.sphinx_rtd_theme
            pp.sphinxcontrib-spelling
            pp.sphinxcontrib-tikz
            pp.sphinx-autobuild
        ]);
      in
      {
        # nix shell
        packages = {
          default = pkgs.buildEnv {
            name = "sphinx-dev";
            paths = [ sphinx tex ];
          };
          autobuild = pkgs.buildEnv {
            name = "sphinx-autobuild";
            paths = [
              (pkgs.writeShellApplication {
                name = "sphinx-autobuild";
                text = ''
                  ${sphinx}/bin/sphinx-autobuild "$@"
                '';
                runtimeInputs = [ sphinx tex ];
              })
            ];
          };
          build = pkgs.buildEnv {
            name = "sphinx-build";
            paths = [
              (pkgs.writeShellApplication {
                name = "sphinx-build";
                text = ''
                  ${sphinx}/bin/sphinx-build "$@"
                '';
                runtimeInputs = [ sphinx tex ];
              })
            ];
          };
        };

        # nix develop
        devShells.default = pkgs.mkShellNoCC {
          name = "sphinx-dev";
          buildInputs = [ sphinx tex ];
        };
      }
    );

}
