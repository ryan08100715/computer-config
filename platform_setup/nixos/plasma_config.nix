{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "org_kde_powerdevil"."powerProfile" = ["Battery,Battery" "Meta+B,切換電源管理設定檔"];
      "services/kitty.desktop"."_launch" = "Meta+Return";
      "services/google-chrome.desktop"."_launch" = "Meta+B";
      "services/org.kde.spectacle.desktop"."RectangularRegionScreenShot" = ["Meta+Shift+Print" "F1"];
      
      # 關閉視窗
      "kwin"."Window Close" = ["Alt+F4" "Ctrl+Q,Alt+F4,關閉視窗"];
 
      # 工作區
      "kwin"."view_actual_size" = "none,Meta+0,縮放到實際大小(A)";
      "plasmashell"."activate task manager entry 1" = "none,Meta+1,啟用工作管理員項目 1";
      "plasmashell"."activate task manager entry 2" = "none,Meta+2,啟用工作管理員項目 2";
      "plasmashell"."activate task manager entry 3" = "none,Meta+3,啟用工作管理員項目 3";
      "plasmashell"."activate task manager entry 4" = "none,Meta+4,啟用工作管理員項目 4";
      "plasmashell"."activate task manager entry 5" = "none,Meta+5,啟用工作管理員項目 5";
      "plasmashell"."activate task manager entry 6" = "none,Meta+6,啟用工作管理員項目 6";
      "plasmashell"."activate task manager entry 7" = "none,Meta+7,啟用工作管理員項目 7";
      "plasmashell"."activate task manager entry 8" = "none,Meta+8,啟用工作管理員項目 8";
      "plasmashell"."activate task manager entry 9" = "none,Meta+9,啟用工作管理員項目 9";
      "plasmashell"."activate task manager entry 10" = "none,Meta+0,啟用工作管理員項目 10";

      "kwin"."Switch to Desktop 1" = "Meta+1,,切換到桌面 1";
      "kwin"."Switch to Desktop 2" = "Meta+2,,切換到桌面 2";
      "kwin"."Switch to Desktop 3" = "Meta+3,,切換到桌面 3";
      "kwin"."Switch to Desktop 4" = "Meta+4,,切換到桌面 4";
      "kwin"."Switch to Desktop 5" = "Meta+5,,切換到桌面 5";
      "kwin"."Switch to Desktop 6" = "Meta+6,,切換到桌面 6";
      "kwin"."Switch to Desktop 7" = "Meta+7,,切換到桌面 7";
      "kwin"."Switch to Desktop 8" = "Meta+8,,切換到桌面 8";
      "kwin"."Switch to Desktop 9" = "Meta+9,,切換到桌面 9";
      "kwin"."Switch to Desktop 10" = "Meta+0,,切換到桌面 10";

      "kwin"."Move with Window to Desktop 1" = "Meta+!,none,Move with Window to Desktop 1";
      "kwin"."Move with Window to Desktop 2" = "Meta+@,none,Move with Window to Desktop 2";
      "kwin"."Move with Window to Desktop 3" = "Meta+#,none,Move with Window to Desktop 3";
      "kwin"."Move with Window to Desktop 4" = "Meta+$,none,Move with Window to Desktop 4";
      "kwin"."Move with Window to Desktop 5" = "Meta+%,none,Move with Window to Desktop 5";
      "kwin"."Move with Window to Desktop 6" = "Meta+^,none,Move with Window to Desktop 6";
      "kwin"."Move with Window to Desktop 7" = "Meta+&,none,Move with Window to Desktop 7";
      "kwin"."Move with Window to Desktop 8" = "Meta+*,none,Move with Window to Desktop 8";
      "kwin"."Move with Window to Desktop 9" = "Meta+(,none,Move with Window to Desktop 9";
      "kwin"."Move with Window to Desktop 10" = "Meta+),none,Move with Window to Desktop 10";
      "kwin"."Move with Window to Desktop 11" = ",none,Move with Window to Desktop 11";
      "kwin"."Move with Window to Desktop 12" = ",none,Move with Window to Desktop 12";
      "kwin"."Move with Window to Desktop 13" = ",none,Move with Window to Desktop 13";
      "kwin"."Move with Window to Desktop 14" = ",none,Move with Window to Desktop 14";
      "kwin"."Move with Window to Desktop 15" = ",none,Move with Window to Desktop 15";
      "kwin"."Move with Window to Desktop 16" = ",none,Move with Window to Desktop 16";
      "kwin"."Move with Window to Desktop 17" = ",none,Move with Window to Desktop 17";
      "kwin"."Move with Window to Desktop 18" = ",none,Move with Window to Desktop 18";
      "kwin"."Move with Window to Desktop 19" = ",none,Move with Window to Desktop 19";
      "kwin"."Move with Window to Desktop 20" = ",none,Move with Window to Desktop 20";
    };
    configFile = {
      "kdeglobals"."Shortcuts"."Help" = "";
      "kdeglobals"."Shortcuts"."Quit" = "";
      "kxkbrc"."Layout"."Options" = "ctrl:nocaps";
      "kxkbrc"."Layout"."ResetOldOptions" = true;
      "kwinrc"."Desktops"."Number" = 10;
      "kwinrc"."Plugins"."move-windows-to-desktopsEnabled" = true;
      "krunnerrc"."General"."FreeFloating" = true;

      # 桌面
      "plasmarc"."Wallpapers"."usersWallpapers" = "/home/ryan/wallpapers/1369866.png";
      # 鎖定畫面
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "/home/ryan/wallpapers/1373157.png";
      "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "/home/ryan/wallpapers/1373157.png";

      # KDE Wallet
      "kwalletrc"."Wallet"."Close When Idle" = false;
      "kwalletrc"."Wallet"."Close on Screensaver" = false;
      "kwalletrc"."Wallet"."Default Wallet" = "kdewallet";
      "kwalletrc"."Wallet"."Enabled" = false;
      "kwalletrc"."Wallet"."First Use" = false;
      "kwalletrc"."Wallet"."Idle Timeout" = 10;
      "kwalletrc"."Wallet"."Launch Manager" = false;
      "kwalletrc"."Wallet"."Leave Manager Open" = false;
      "kwalletrc"."Wallet"."Leave Open" = true;
      "kwalletrc"."Wallet"."Prompt on Open" = false;
      "kwalletrc"."Wallet"."Use One Wallet" = true;
      "kwalletrc"."org.freedesktop.secrets"."apiEnabled" = true;

      # 在 wayland 時,設定虛擬鍵盤
      "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop";
    };
  };
}
