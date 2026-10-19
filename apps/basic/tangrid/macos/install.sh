#!/usr/bin/env bash

# Tangrid 沒有 brew cask，從官方更新來源（Sparkle appcast）取得最新版下載網址
URL=$(curl -fsSL https://api.tangrid.app/appcast.xml | grep -o -m1 'url="[^"]*\.zip"' | cut -d'"' -f2)
TMP_DIR=$(mktemp -d)

# 用 ditto 解壓，才能保留 App 的附加屬性與簽章
curl -fsSL "$URL" -o "$TMP_DIR/tangrid.zip"
ditto -x -k "$TMP_DIR/tangrid.zip" /Applications
rm -rf "$TMP_DIR"
