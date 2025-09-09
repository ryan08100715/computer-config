#!/usr/bin/env bash

# * 取得當前腳本所在的目錄
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# * 執行其他腳本
bash "$SCRIPT_DIR/../../apps/basic/git/config_setup.sh"
bash "$SCRIPT_DIR/../../apps/shell/fish/install.sh"
chsh -s /usr/bin/fish
bash "$SCRIPT_DIR/../../apps/shell/starship/install.sh"
bash "$SCRIPT_DIR/../../apps/shell/starship/config_setup.sh"
bash "$SCRIPT_DIR/../../apps/terminal_tools/eza/install.sh"
