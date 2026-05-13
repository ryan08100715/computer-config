#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# link config
ln -sf "$(realpath "$SCRIPT_DIR/../config/.aerospace.toml")" "$HOME/.aerospace.toml"
