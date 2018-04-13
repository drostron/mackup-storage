#!/usr/bin/env bash

# Referenced at https://github.com/NixOS/nix/pull/1090
# from https://github.com/cspickert/fish/blob/master/misc/nix_fish_env.sh
# Additions
# - MANPATH
# - NIX_REMOTE

# Usage from fish: "eval (./nix_fish_env) 2>/dev/null"

# Abort if nix isn't installed
if ! [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
    exit
fi

# Unset variables that will be loaded from nix init
unset PATH
unset SSL_CERT_FILE

# Load environment from nix init
source ~/.nix-profile/etc/profile.d/nix.sh

# Remove trailing `:` from PATH
PATH="${PATH%:}"

# Read PATH and NIX_PATH into arrays
IFS=: read -a PATH_ARRAY <<< "$PATH"
IFS=: read -a NIX_PATH_ARRAY <<< "$NIX_PATH"

# Echo fish commands to export environment variables
echo set -x PATH ${PATH_ARRAY[@]} \$PATH \;
echo set -x MANPATH "$NIX_LINK"/share/man \$MANPATH \;
echo set -x NIX_PATH ${NIX_PATH_ARRAY[@]} \;

# See https://github.com/NixOS/nixpkgs/issues/5713
echo set -x NIX_REMOTE daemon \;

if [ -f "$NIX_SSL_CERT_FILE" ]; then
    echo set -x SSL_CERT_FILE \'$NIX_SSL_CERT_FILE\' \;
fi
