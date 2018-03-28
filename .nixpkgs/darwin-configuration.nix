# Bootstrapped from https://github.com/LnL7/nix-darwin/blob/master/modules/examples/lnl.nix

{ config, lib, pkgs, ... }:

let
  # TODO more conventional way to access overlays?
  nixpkgs = import <nixpkgs> { };
  aspellWithDict = pkgs.aspellWithDicts(ps: with ps; [ en ]);
in {
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadRightClick = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  # See nix-notes.md ToDo
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToControl = true;

  environment.systemPackages =
    [
    # Emacs
    # TODO make deps available to emacs app other than globally
    nixpkgs.emacsHeadCustom
    # ispell is erroring out on package install/compilation
    aspellWithDict
    pkgs.gcc

    # pkgs.brotli
    pkgs.ctags
    pkgs.curl
    pkgs.entr
    # pkgs.fzf
    # pkgs.gettext
    pkgs.git
    # pkgs.gnupg
    pkgs.gnumake
    pkgs.htop
    pkgs.jq
    # pkgs.mosh
    pkgs.neovim
    # pkgs.ripgrep
    pkgs.sbt
    pkgs.shellcheck
    pkgs.silver-searcher
    pkgs.tree

    # pkgs.khd
    # pkgs.kwm

    pkgs.nix-repl
    ];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  # programs.zsh.enable = true;
  # programs.fish.enable = true;

  # A few shell aliases
  environment.shellAliases.g = "git";
  environment.shellAliases.gs = "git status";
  environment.shellAliases.gd = "git diff";
  environment.shellAliases.ll = "ls -lh";
  environment.shellAliases.la = "ls -lah";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 2;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 8;
  nix.buildCores = 1;

  # Default of true causing `warning: unknown setting 'signed-binary-caches'`
  # due to `signed-binary-caches = *` in /etc/nix/nix.conf
  nix.requireSignedBinaryCaches = false;
}
