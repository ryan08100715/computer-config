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