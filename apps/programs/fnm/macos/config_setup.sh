#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# 有安裝 fish shell 時，會將 fnm 相關設定設定到 fish shell 中
if command -v fish &>/dev/null; then

    # 配置 config
    FISH_CONFIG_DIR="$HOME/.config/fish/conf.d"
    mkdir -p "$FISH_CONFIG_DIR"

    for file in "$SCRIPT_DIR/../fish_config/conf.d/"*.fish; do
        ln -sf "$(realpath "$file")" "$FISH_CONFIG_DIR/$(basename "$file")"
    done
fi
