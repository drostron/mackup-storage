self: super:
{
  local = import ~/code/nixpkgs {};

  pinned = import (builtins.fetchGit {
    url = "git://github.com/nixos/nixpkgs";
    rev = "d7d31fea7e7eef8ff4495e75be5dcbb37fb215d0";
  }) {};

  unstable = import (builtins.fetchGit {
    url = "git://github.com/NixOS/nixpkgs-channels";
    ref = "nixos-unstable";
  }) {};

  master = import (builtins.fetchGit {
    url = "git://github.com/nixos/nixpkgs";
    ref = "master";
  }) {};
}
