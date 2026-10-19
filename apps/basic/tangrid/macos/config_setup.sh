#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
DOMAIN="com.wrapper.Tangrid"

# 先結束 Tangrid，避免執行中的 App 用記憶體裡的舊設定覆蓋回去
if pgrep -xq Tangrid; then
    osascript -e "quit app id \"$DOMAIN\""
    while pgrep -xq Tangrid; do sleep 0.5; done
fi

# 匯入設定
defaults import "$DOMAIN" "$SCRIPT_DIR/../config/$DOMAIN.plist"

open -b "$DOMAIN"
