## 1. 建立 WSL 實例

透過 apps/wsl/create_wsl_instance.ps1 建立 WSL：

```shell
apps/wsl/create_wsl_instance.ps1 -WSLName <wsl-name>
```

## 2. Windows Terminal 配置(可選)

以系統管理員執行配置腳本：

```shell
apps/terminal/windows_terminal/config_setup.ps1
```

## 3. 初始化配置

進入 WSL 系統後以 sudo 執行 init_wsl.sh。

```shell
sudo /mnt/c/Users/Ryan/computer-config/platform_setup/wsl/init_wsl.sh
```

## 4. 設定預設登入使用者並重新啟動

```shell
wsl --terminate <wsl-name>
wsl --manage <wsl-name> --set-default-user ryan
```

## 5. 根據需求執行 setup 腳本