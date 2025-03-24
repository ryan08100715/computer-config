## 手動配置

1. 註冊使用者

```sh
adduser ryan

usermod -aG sudo ryan
```

2. 設定登入的預設使用者

```powershell
wsl --manage <distro-name> --set-default-user ryan
```

3. 讓 WSL 有權限讀寫 /mnt 資料

在 /etc/wsl.conf 添加 automount.options = "metadata"

```
[automount]
options = "metadata"
```
設定後記得關閉 WSL 重新開啟

```sh
wsl --terminate <distro-name>
```
