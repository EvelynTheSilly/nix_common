#!/usr/bin/env nix-shell
#! nix-shell -i nu -p nushell
nix run github:nix-community/home-manager -- switch --flake .#asahi_mac
