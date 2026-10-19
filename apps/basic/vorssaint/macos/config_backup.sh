#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
DOMAIN="com.vorssaint.utils"
CONFIG_FILE="$SCRIPT_DIR/../config/$DOMAIN.plist"

# 匯出目前設定，並移除只屬於這台電腦的值（視窗大小、硬體狀態、已讀版本、隨機金鑰等）
defaults export "$DOMAIN" - | python3 -c '
import fnmatch, plistlib, sys

EXCLUDE = [
    "NSOSPLastRootDirectory",
    "NSStatusItem Preferred Position *",
    "settingsWindowWidth",
    "settingsWindowHeight",
    "brightnessDDCWriteOnlyPathsRechecked",
    "bluetoothSleepRestorePending",
    "commandBarQueryHabitKey",
    "shelfItems",
    "*IntroVersion",
    "updateHighlightsSeenVersion",
]

prefs = plistlib.loads(sys.stdin.buffer.read())
prefs = {k: v for k, v in prefs.items() if not any(fnmatch.fnmatchcase(k, p) for p in EXCLUDE)}

# 讀取成功才寫檔，避免匯出失敗時把既有備份清空
with open(sys.argv[1], "wb") as f:
    plistlib.dump(prefs, f, fmt=plistlib.FMT_XML, sort_keys=True)
' "$CONFIG_FILE"
