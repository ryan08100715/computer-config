#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# 有安裝 fish shell 時，會將 herd 相關設定設定到 fish shell 中
if command -v fish &>/dev/null; then

    # 添加 herd 的 bin 路徑
    fish -c "fish_add_path -U '$HOME/Library/Application Support/Herd/bin/'"

    # 配置 config
    FISH_CONFIG_DIR="$HOME/.config/fish/conf.d"
    mkdir -p "$FISH_CONFIG_DIR"

    for file in "$SCRIPT_DIR/../fish_config/conf.d/"*.fish; do
        ln -sf "$(realpath "$file")" "$FISH_CONFIG_DIR/$(basename "$file")"
    done

    # 配置 functions
    FISH_FUNCTIONS_DIR="$HOME/.config/fish/functions"
    mkdir -p "$FISH_FUNCTIONS_DIR"

    for file in "$SCRIPT_DIR/../fish_config/functions/"*.fish; do
        ln -sf "$(realpath "$file")" "$FISH_FUNCTIONS_DIR/$(basename "$file")"
    done
fi
