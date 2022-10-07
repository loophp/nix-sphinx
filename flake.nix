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
      in
      {
        # nix run
        apps = {
          autobuild = {
            type = "app";
            program = "${sphinx}/bin/sphinx-autobuild";
          };
          build = {
            type = "app";
            program = "${sphinx}/bin/sphinx-build";
          };
        };

        # nix shell
        packages = {
          default = pkgs.buildEnv {
            name = "sphinx-dev";
            paths = [ sphinx ];
          };
        };

        # nix develop
        devShells.default = pkgs.mkShellNoCC {
          name = "sphinx-dev";
          buildInputs = [ sphinx ];
        };
      }
    );

}
