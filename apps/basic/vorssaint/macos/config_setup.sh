#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
DOMAIN="com.vorssaint.utils"

# 先結束 Vorssaint，避免執行中的 App 用記憶體裡的舊設定覆蓋回去
if pgrep -xq Vorssaint; then
    osascript -e "quit app id \"$DOMAIN\""
    while pgrep -xq Vorssaint; do sleep 0.5; done
fi

# 匯入設定
defaults import "$DOMAIN" "$SCRIPT_DIR/../config/$DOMAIN.plist"

open -b "$DOMAIN"
