#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
APPS_DIR="$SCRIPT_DIR/../../apps"

###########
# 依賴工具 #
###########

# * 安裝 homebrew
bash "$APPS_DIR/basic/homebrew/macos/install.sh"

# 需要先配置 homebrew

###########
# 系統工具 #
###########

# * 安裝 stats
bash "$APPS_DIR/basic/stats/macos/install.sh"

# * 安裝 better display
bash "$APPS_DIR/basic/betterdisplay/macos/install.sh"

# * 安裝 keka
bash "$APPS_DIR/basic/keka/macos/install.sh"

####################
# Terminal & Shell #
####################

# * 安裝 jetbrains mono nerd font
bash "$APPS_DIR/fonts/jetbrains_mono_nerd_font/macos/install.sh"

# * 安裝 fish
bash "$APPS_DIR/shell/fish/macos/install.sh"
bash "$APPS_DIR/shell/fish/macos/config_setup.sh"

# * 安裝 starship
bash "$APPS_DIR/shell/starship/macos/install.sh"
bash "$APPS_DIR/shell/starship/macos/config_setup.sh"

# * 安裝 iTerm2
bash "$APPS_DIR/terminal/iterm2_terminal/macos/install.sh"

# * 安裝 eza
bash "$APPS_DIR/terminal_tools/eza/macos/install.sh"

# * 安裝 bat
bash "$APPS_DIR/terminal_tools/bat/macos/install.sh"

################
# 自己使用的程式 #
################

# * 安裝 Google Drive
bash "$APPS_DIR/cloud_storage/google_drive/macos/install.sh"

# * 安裝 1Password
bash "$APPS_DIR/misc/1password/macos/install.sh"

###########
# 程式開發 #
###########

# * 安裝 Visual Studio Code
bash "$APPS_DIR/editor/vscode/macos/install.sh"

# * 安裝 Jetbrains Toolbox
bash "$APPS_DIR/editor/jetBrains_toolbox/macos/install.sh"

# * 安裝 Herd
bash "$APPS_DIR/programs/herd/macos/install.sh"

# * 安裝 DBeaver
bash "$APPS_DIR/database_manager_tools/dbeaver/macos/install.sh"

# * 安裝 Redis Insight
bash "$APPS_DIR/database_manager_tools/redis_insight/macos/install.sh"

# * 安裝 Docker Desktop
bash "$APPS_DIR/virtualization/docker_desktop/macos/install.sh"

# * 安裝 Apidog
bash "$APPS_DIR/api_client/apidog/macos/install.sh"

# * 安裝 Drawio
bash "$APPS_DIR/misc/drawio/macos/install.sh"
