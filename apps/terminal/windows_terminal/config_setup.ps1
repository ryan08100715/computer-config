#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1

function Get-Settings {
  # Windows Terminal settings 路徑
  $settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

  # 確保文件存在
  if (-not (Test-Path $settingsPath)) {
    Write-MyError -Icon "Windows Terminal settings.json not found!"
    exit 1
  }

  # 讀取當前 settings.json
  $settings = Get-Content $settingsPath | ConvertFrom-Json

  return $settings
}

function Save-Settings {
  param (
    [Parameter(Mandatory)]
    [object]$Settings
  )
  # Windows Terminal settings 路徑
  $settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

  # 將更新後的設置寫回 settings.json
  $Settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath
}

function Add-ThemesFromDirectory {
  param (
    [Parameter(Mandatory)]
    [string]$ThemesDirectory,
    [Parameter(Mandatory)]
    [object]$Settings
  )

  # 確保主題目錄存在
  if (-not (Test-Path $ThemesDirectory)) {
    Write-MyWarning -Icon "Theme directory not found: $ThemesDirectory"
    return
  }

  # 遍歷目錄中的所有 .json 文件
  $themeFiles = Get-ChildItem -Path $ThemesDirectory -Filter "*.json"

  foreach ($themeFile in $themeFiles) {
    try {
      # 讀取主題文件
      $themeContent = Get-Content $themeFile.FullName | ConvertFrom-Json

      # 檢查主題是否已存在
      $existingTheme = $Settings.themes | Where-Object { $_.name -eq $themeContent.name }
      if ($existingTheme) {
        Write-MyWarning -Icon "Theme $($themeContent.name) already exists. Skipping."
        continue
      }

      # 添加新主題到 themes 數組
      $Settings.themes += $themeContent

      Write-MySuccess -Icon "Added theme: $($themeContent.name)"
    }
    catch {
      Write-MyError -Icon "Error processing theme file: $($themeFile.Name)"
      Write-MyError $_.Exception.Message
    }
  }

  Write-MyInfo "Finished adding themes from directory: $ThemesDirectory"

  return $Settings
}

function Add-SchemesFromDirectory {
  param (
    [Parameter(Mandatory)]
    [string]$SchemesDirectory,
    [Parameter(Mandatory)]
    [object]$Settings
  )

  # 確保主題目錄存在
  if (-not (Test-Path $SchemesDirectory)) {
    Write-MyWarning -Icon "Scheme directory not found: $SchemesDirectory"
    return
  }

  # 遍歷目錄中的所有 .json 文件
  $schemesFiles = Get-ChildItem -Path $SchemesDirectory -Filter "*.json"

  foreach ($schemeFile in $schemesFiles) {
    try {
      # 讀取主題文件
      $schemeContent = Get-Content $schemeFile.FullName | ConvertFrom-Json

      # 檢查主題是否已存在
      $existingScheme = $Settings.schemes | Where-Object { $_.name -eq $schemeContent.name }
      if ($existingScheme) {
        Write-MyWarning -Icon "Scheme $($schemeContent.name) already exists. Skipping."
        continue
      }

      # 添加新主題到 schemes 數組
      $Settings.schemes += $schemeContent

      Write-MySuccess -Icon "Added scheme: $($schemeContent.name)"
    }
    catch {
      Write-MyError -Icon "Error processing scheme file: $($schemeFile.Name)"
      Write-MyError $_.Exception.Message
    }
  }

  Write-MyInfo "Finished adding schemes from directory: $SchemesDirectory"

  return $Settings
}

function Set-AllProfileThemeAndFont {
  param (
    [Parameter(Mandatory)]
    [object]$Settings
  )

  # 遍歷 profiles.list
  foreach ($profile in $Settings.profiles.list) {
    # 添加 colorScheme
    $profile | Add-Member -MemberType NoteProperty -Name "colorScheme" -Value "rose-pine" -Force

    # 添加 font 配置
    $fontConfig = @{
      face = "JetBrainsMono Nerd Font"
      size = 14
    }
    $profile | Add-Member -MemberType NoteProperty -Name "font" -Value $fontConfig -Force

    # 添加半透明背景
    $profile | Add-Member -MemberType NoteProperty -Name "opacity" -Value 90 -Force

    # 自動調整無法分辨的文字亮度
    $profile | Add-Member -MemberType NoteProperty -Name "adjustIndistinguishableColors" -Value "indexed" -Force

    # 固定 tab title
    $profile | Add-Member -MemberType NoteProperty -Name "suppressApplicationTitle" -Value $true -Force
  }

  return $Settings
}

function Set-KeyBindings {
  param (
    [Parameter(Mandatory)]
    [object]$Settings
  )
  if (-not $Settings.keybindings) {
    Add-Member -InputObject $Settings -NotePropertyName "keybindings" -NotePropertyValue @()
  }

  # 要綁定的客製化快捷鍵
  $customKeybindings = @(
    @{
      "id"      = "My.NewTab"
      "keys"    = "ctrl+t"
      "command" = "newTab"
    }
    @{
      "id"      = "My.CloseTab"
      "keys"    = "ctrl+w"
      "command" = "closeTab"
    }
    @{
      "id"      = "My.OpenSettingsUI"
      "keys"    = "ctrl+alt+s"
      "command" = @{
        "action" = "openSettings"
        "target" = "settingsUI"
      }
    }
    @{
      "id"      = "My.OpenNewTabDropdown"
      "keys"    = "ctrl+d"
      "command" = "openNewTabDropdown"
    }
  )

  foreach ($key in $customKeybindings) {
    # keybindings 陣列中沒有才添加
    if (-not ($Settings.keybindings | Where-Object { $_.id -eq $key['id'] })) {
      $Settings.keybindings += @{
        "id"   = $key['id']
        "keys" = $key['keys']
      }
    }

    # actions 陣列中沒有才添加
    if (-not ($Settings.actions | Where-Object { $_.id -eq $key['id'] })) {
      $Settings.actions += @{
        "id"      = $key['id']
        "command" = $key['command']
      }
    }

    Write-MySuccess -Icon "成功添加快捷鍵: $($key | ConvertTo-Json -Compress )"
  }

  return $Settings
}

Write-MyInfo "開始進行 Windows Terminal 配置..."

# * 配置設定檔
$settings = Get-Settings

$themesDir = "$PSScriptRoot\themes"
$settings = Add-ThemesFromDirectory -ThemesDirectory $themesDir -Settings $settings

$schemesDir = "$PSScriptRoot\schemes"
$settings = Add-SchemesFromDirectory -SchemesDirectory $schemesDir -Settings $settings

$settings = Set-AllProfileThemeAndFont -Settings $settings
Write-MySuccess -Icon "設置所有Profiles"

$settings | Add-Member -MemberType NoteProperty -Name "theme" -Value "rose-pine" -Force
Write-MySuccess -Icon "設置主題為: rose-pine"

$settings | Add-Member -MemberType NoteProperty -Name "defaultProfile" -Value "{574e775e-4f2a-5b96-ac1e-a2962a402336}" -Force
Write-MySuccess -Icon "設置預設設定檔為: powershell"

$settings = Set-KeyBindings -Settings $settings

if ($null -eq ($settings.actions | Where-Object { $_.id -eq 'twitch.folder' })) {
  $settings.actions += @{
    "id"      = "twitch.folder"
    "name"    = "Twitch Folder"
    "command" = @{
      "action"            = "newTab"
      "profile"           = "PowerShell"
      "startingDirectory" = "D:\\twitch_download"
    }
  }
  Write-MySuccess -Icon "添加 Twitch Folder 命令"
}

Save-Settings -Settings $settings

Write-MySuccess "Windows Terminal 配置完成..."
Write-MyInfo ""
