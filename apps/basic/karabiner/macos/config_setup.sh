#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# 複製設定檔，Karabiner 偵測到檔案變動會自動重新載入，不用重開 App
mkdir -p "$HOME/.config/karabiner"
cp "$SCRIPT_DIR/../config/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
