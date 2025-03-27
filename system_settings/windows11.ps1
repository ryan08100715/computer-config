#!/usr/bin/env pwsh

#Requires -RunAsAdministrator

. $PSScriptRoot\..\utils\output.ps1
. $PSScriptRoot\..\utils\registry.ps1

function Sync-ImagesDirectory {
  $imagesDir = "$HOME\images"
  New-Item -ItemType SymbolicLink -Path "$imagesDir" -Target "$PSScriptRoot\images" -Force | Out-Null
  Write-MySuccess -Icon "同步 $imagesDir 資料夾"
}

function Set-SystemAudio {
  # 當 Windows 偵測到通訊活動時
  # 0：Mute all other sounds (靜音所有其他聲音)
  # 1：Reduce the volume of other sounds by 80% (將其他聲音降低 80%)
  # 2：Reduce the volume of other sounds by 50% (將其他聲音降低 50%)
  # 3：Do nothing (不進行動作)
  $value = 3
  Set-Registry -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Value $value -Type DWord
  Write-MySuccess -Icon "設置系統音訊"
}

function Set-SystemPower {
  # 在此時間之後關閉我的螢幕 (ac = 電源, dc = 電池)
  POWERCFG /CHANGE monitor-timeout-ac 0
  POWERCFG /CHANGE monitor-timeout-dc 5

  # 在以下時間後讓裝置進入睡眠狀態 (ac = 電源, dc = 電池)
  POWERCFG /CHANGE standby-timeout-ac 0
  POWERCFG /CHANGE standby-timeout-dc 0

  # 在以下時間後讓裝置進入休眠狀態 (ac = 電源, dc = 電池)
  POWERCFG /CHANGE hibernate-timeout-ac 0
  POWERCFG /CHANGE hibernate-timeout-dc 0

  Write-MySuccess -Icon "設置系統電源"
}

function Set-PersonalizationBackground {
  # 桌面壁紙路徑
  $wallpaperPath = "$HOME\images\wallpaper.png"
  Set-Registry -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper" -Value $wallpaperPath -Type String

  Write-MySuccess -Icon "設置桌面"
}

function Set-PersonalizationColors {
  # 選擇你的模式 (0 = 深色, 1 = 淺色)
  $mode = 0
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value $mode -Type DWord
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value $mode -Type DWord

  # 輔色
  $accentColor = 0xFF0C63F7 #F7630C (BGR: 0x0C63F7)
  $startColor = 0xFF0753E0 #E05307 (BGR: 0x0753E0)
  $accentPalette = [byte[]](
    0xFE, 0xBD, 0x68, 0x00, # 淺橘色
    0xFB, 0x9A, 0x44, 0x00, # 中間漸層
    0xF8, 0x74, 0x1D, 0x00, # 目標橘色 #F7630C
    0xF7, 0x63, 0x0C, 0x00, # 稍深橘色
    0xE0, 0x53, 0x07, 0x00, # 更深橘色
    0xA1, 0x31, 0x05, 0x00, # 深橘色
    0x69, 0x12, 0x02, 0x00, # 接近棕色
    0x00, 0x99, 0xBC, 0x00  # 系統保留色
  )
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColor" -Value $accentColor -Type DWord
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableWindowColorization" -Value 1 -Type DWord
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentColorMenu" -Value $accentColor -Type DWord
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "StartColorMenu" -Value $startColor -Type DWord
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette" -Value $accentPalette -Type Binary

  Write-MySuccess -Icon "設置系統顏色"
}

function Set-PersonalizationDynamicLighting {
  # 在我的裝置上使用動態光效 (0 = 不啟用, 1 = 啟用)
  $value = 0
  Set-Registry -Path "HKCU:\Software\Microsoft\Lighting" -Name "AmbientLightingEnabled" -Value $value -Type DWord

  # 前景中相容的應用程式一律可控制光線 (0 = 不啟用, 1 = 啟用)
  $value = 0
  Set-Registry -Path "HKCU:\Software\Microsoft\Lighting" -Name "ControlledByForegroundApp" -Value $value -Type DWord

  Write-MySuccess -Icon "設置動態燈光"
}

function Set-PersonalizationLockScreen {
  # 背景圖片
  $imagePath = "$HOME\images\lockscreen.png"
  Set-Registry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value $imagePath -Type String

  # 設定鎖定畫面選項（0 = 自訂圖片）
  $value = 0
  Set-Registry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Value $value -Type DWord

  Write-MySuccess -Icon "設置螢幕鎖定圖片"
}

function Set-PersonalizationStart {
  # 設定開始菜單樣式 (0 = 預設, 1 = 更多釘選項目, 2 = 更多建議) (由 Win11Debloat 設定)
  # $layout = 0
  # Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Value $layout -Type DWord

  # 設定顯示最近新增的應用程式 (0 = 不顯示, 1 = 顯示) (由 Win11Debloat 設定)
  # $recents = 0
  # Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" -Name "ShowRecentList" -Value $recents -Type DWord

  # 設定顯示常用的應用程式 (0 = 不顯示, 1 = 顯示) (由 Win11Debloat 設定)
  # $frequent = 0
  # Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" -Name "ShowFrequentList" -Value $frequent -Type DWord

  # 設定顯示建議檔案、最近使用的檔案 (0 = 不顯示, 1 = 顯示) (由 Win11Debloat 設定)
  $suggestions = 0
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value $suggestions -Type DWord

  # 設定顯示提示、捷徑等建議 (0 = 不顯示, 1 = 顯示) (由 Win11Debloat 設定)
  # $tips = 0
  # Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_IrisRecommendations" -Value $tips -Type DWord

  # 資料夾 (開始選單關機按鈕旁邊要顯示的icons)
  # 只顯示系統設定
  $visiblePlaces = [byte[]](
    0x86, 0x08, 0x73, 0x52,
    0xAA, 0x51, 0x43, 0x42,
    0x9F, 0x7B, 0x27, 0x76,
    0x58, 0x46, 0x59, 0xD4
  )
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" -Name "VisiblePlaces" -Value $visiblePlaces -Type Binary

  # 隱藏 recommended 區塊 (由 Win11Debloat 設定)
  # Set-Registry -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Name "IsEducationEnvironment" -Value 1 -Type DWord
  # Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecommendedSection" -Value 1 -Type DWord
  # Set-Registry -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "HideRecommendedSection" -Value 1 -Type DWord

  Write-MySuccess -Icon "設置開始菜單"
}

function Setup-Taskbar {
  # 搜尋 (0 = 隱藏, 1 = 僅圖示, 2 = 圖示和標籤, 3 = 搜尋方塊)
  $search = 0
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value $search -Type DWord

  # 工作檢視 (0 = 隱藏, 1 = 顯示)
  $taskview = 0
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value $taskview -Type DWord

  # 小工具 (0 = 隱藏, 1 = 顯示)
  $widgets = 0
  Set-Registry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value $widgets -Type DWord

  # Chat (0 = 隱藏, 1 = 顯示)
  $chat = 0
  Set-Registry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value $chat -Type DWord
}

Sync-ImagesDirectory
Set-SystemAudio
Set-SystemPower
Set-PersonalizationBackground
Set-PersonalizationColors
Set-PersonalizationDynamicLighting
Set-PersonalizationLockScreen
Set-PersonalizationStart
# Setup-Taskbar (由 Win11Debloat 設定)
