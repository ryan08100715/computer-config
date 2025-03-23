#!/usr/bin/env bash

# 詢問使用者 VERSION
read -r -p "請輸入版本號 (例如 10.10.5): " VERSION

# 檢查 VERSION 是否為空
if [ -z "$VERSION" ]; then
  echo "錯誤：版本號不能為空"
  exit 1
fi

# 詢問使用者備份路徑
read -r -p "請輸入備份路徑 (預設為 /mnt/d/jellyfin_backup): " BACKUP_PATH

# 如果使用者未輸入路徑，使用預設值
BACKUP_PATH=${BACKUP_PATH:-/mnt/d/jellyfin_backup}

echo "關閉 Jellyfin 服務..."
sudo systemctl stop jellyfin.service

# 產生時間戳記
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# 檢查備份路徑是否存在，如果不存在則建立
if [ ! -d "$BACKUP_PATH" ]; then
  echo "備份路徑不存在，正在建立..."
  sudo mkdir -p "$BACKUP_PATH"
fi

# 建立完整的備份路徑
FULL_BACKUP_PATH="${BACKUP_PATH}/jellyfin.${TIMESTAMP}_${VERSION}"

echo "正在建立備份目錄: $FULL_BACKUP_PATH"
sudo mkdir -p "$FULL_BACKUP_PATH"

echo "正在複製 Jellyfin 資料..."
sudo cp -a /var/lib/jellyfin "$FULL_BACKUP_PATH/data"

echo "正在複製 Jellyfin 設定檔..."
sudo cp -a /etc/jellyfin "$FULL_BACKUP_PATH/config"

echo "備份完成！"
echo "備份位置: $FULL_BACKUP_PATH"

echo "啟動 Jellyfin 服務..."
sudo systemctl start jellyfin.service
