#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# 有安裝 fish shell 時，會將 bat 相關設定設定到 fish shell 中
if command -v fish &>/dev/null; then

    # 配置 functions
    FISH_FUNCTIONS_DIR="$HOME/.config/fish/functions"
    mkdir -p "$FISH_FUNCTIONS_DIR"

    for file in "$SCRIPT_DIR/../fish_config/functions/"*.fish; do
        ln -sf "$(realpath "$file")" "$FISH_FUNCTIONS_DIR/$(basename "$file")"
    done
fi
