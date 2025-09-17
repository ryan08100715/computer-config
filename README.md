# computer-config

## 先決條件

1. 在 Windows PowerShell 中，以系統管理員執行，並執行以下命令：

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

2. 透過微軟商店 or winget 安裝 PowerShell7，該專案 ps1 腳本都將使用 PowerShell7 執行

## 使用方法

所有腳本以系統管理員執行

### 1. 更改Winget網路設定(Optional)

> 將 downloader 配置為 wininet 可能有助於提高 winget 下載速度

步驟1: 使用 winget config 打開配置檔

步驟2: 添加以下配置
```
"network": {
  "downloader": "wininet"
}
```

### 2. 安裝必要模組

執行 prerequisites.ps1 安裝必要模組

### 3. 執行系統設置腳本

Windows11 系統設置腳本執行後需手動設置的選項：

1. 本地帳號頭像
2. 調整開始選單的建議項目
3. 調整工作列的釘選項目
4. 禁用工作列的閃爍

### 4. 根據需求執行對應腳本

1. platform_setup 資料夾下根據作業系統跟使用環境，提供一組預定義好的環境設置腳本

2. apps、personalization、services 資料夾提供個別的腳本，可以單獨執行

### 5. WSL 發行版請重新開機後在進行安裝

## Q&A

### Winget 下載速度很慢

1. 請嘗試將 winget config 的 downloader 設置成 "wininet"
2. 如果還是不行，可以使用 Cloudflare WARP VPN