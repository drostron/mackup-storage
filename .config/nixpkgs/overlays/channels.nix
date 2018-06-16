self: super:
{
  unstable = import (builtins.fetchTarball
    https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  ) {};

  master = import (builtins.fetchGit {
    url = "git://github.com/nixos/nixpkgs";
    ref = "master";
  }) {};
}
