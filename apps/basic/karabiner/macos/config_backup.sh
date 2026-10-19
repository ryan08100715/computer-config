#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# 把目前的設定複製進 repo
cp "$HOME/.config/karabiner/karabiner.json" "$SCRIPT_DIR/../config/karabiner.json"
