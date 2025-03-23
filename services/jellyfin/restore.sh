#!/usr/bin/env bash

# 詢問使用者備份路徑
read -r -p "請輸入備份路徑: " BACKUP_PATH

# 檢查 BACKUP_PATH 是否為空
if [ -z "$BACKUP_PATH" ]; then
  echo "錯誤：備份路徑不能為空"
  exit 1
fi

# 檢查備份路徑是否存在
if [ ! -d "$BACKUP_PATH" ]; then
  echo "錯誤：備份路徑不存在"
  exit 1
fi

echo "關閉 Jellyfin 服務..."
sudo systemctl stop jellyfin.service

sudo rm -rf /var/lib/jellyfin.bak
sudo rm -rf /etc/jellyfin.bak
echo "將目前的 Jellyfin 資料移動到 /var/lib/jellyfin.bak"
sudo mv /var/lib/jellyfin /var/lib/jellyfin.bak
echo "將目前的 Jellyfin 配置移動到 /etc/jellyfin.bak"
sudo mv /etc/jellyfin /etc/jellyfin.bak

echo "正在恢復 Jellyfin 資料..."
sudo cp -a "$BACKUP_PATH/data" /var/lib/jellyfin
sudo cp -a "$BACKUP_PATH/config" /etc/jellyfin

echo "備份已恢復，請手動啟動 Jellyfin 服務"
