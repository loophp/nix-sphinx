[![Sponsor!][sponsor github]][sponsor github link]

# Nix Sphinx

This [flake][nix flake] provides a quick way to run a local
[sphinx][sphinx homepage] server that build the documentation of your project
just like it would be built on https://readthedocs.org/.

The idea behind this tool is to have a quick up-and-running tool to generate a
changelog using [Nix][nix homepage].

## Usage

While being extremely stable for years, "[flake][nix flake]" is an upcoming
feature of the Nix package manager. In order to use it, you must explicitly
enable it, please check the documentation to enable it, this is currently an
opt-in option.

To run a local server of your documentation, run:

```shell
nix run github:loophp/nix-sphinx#autobuild -- <sourcedir> <outdir>
```

To just build the documentation, run:

```shell
nix run github:loophp/nix-sphinx#build -- <sourcedir> <outdir>
```

* `<sourcedir>` must be replaced by the directory containing the documentation
* `<outdir>` must be replaced by a directory where the documentation will be
  generated, usually in a directory which is ignored by your source version
  control.

## Contributing

Feel free to contribute by sending pull requests. We are a
usually very responsive team and we will help you going
through your pull request from the beginning to the end.

For some reasons, if you can't contribute to the code and
willing to help, sponsoring is a good, sound and safe way
to show us some gratitude for the hours we invested in this
package.

Sponsor me on [Github][sponsor github link] and/or any of
[the contributors][github contributors].

## Changelog

See [CHANGELOG.md][changelog file] for a changelog based on [git commits][github commit history].

For more detailed changelogs, please check [the release changelogs][github release changelogs].

[nix flake]: https://nixos.wiki/wiki/Flakes
[sponsor github]: https://img.shields.io/badge/Sponsor-Github-brightgreen.svg?style=flat-square
[sponsor github link]: https://github.com/sponsors/drupol
[nix homepage]: https://nixos.org/
[sphinx homepage]: https://www.sphinx-doc.org/
[changelog file]: https://github.com/loophp/nix-sphinx/blob/main/CHANGELOG.md
[github commit history]: https://github.com/loophp/nix-sphinx/commits/main
[github release changelogs]: https://github.com/loophp/nix-sphinx/releases
[github contributors]: https://github.com/loophp/nix-sphinx/graphs/contributors
