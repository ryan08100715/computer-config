#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\utils.ps1

function Get-Settings {
  # Windows Terminal settings 路徑
  $settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    
  # 確保文件存在
  if (-not (Test-Path $settingsPath)) {
    Write-Host "Windows Terminal settings.json not found!" -ForegroundColor Red
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
    Write-Host "Theme directory not found: $ThemesDirectory" -ForegroundColor Red
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
        Write-Host "Theme $($themeContent.name) already exists. Skipping." -ForegroundColor Yellow
        continue
      }

      # 添加新主題到 themes 數組
      $Settings.themes += $themeContent

      Write-Host "Added theme: $($themeContent.name)" -ForegroundColor Green
    }
    catch {
      Write-Host "Error processing theme file: $($themeFile.Name)" -ForegroundColor Red
      Write-Host $_.Exception.Message -ForegroundColor Red
    }
  }

  Write-Host "Finished adding themes from directory: $ThemesDirectory" -ForegroundColor Green

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
    Write-Host "Theme directory not found: $SchemesDirectory" -ForegroundColor Red
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
        Write-Host "Theme $($schemeContent.name) already exists. Skipping." -ForegroundColor Yellow
        continue
      }

      # 添加新主題到 schemes 數組
      $Settings.schemes += $schemeContent

      Write-Host "Added scheme: $($schemeContent.name)" -ForegroundColor Green
    }
    catch {
      Write-Host "Error processing scheme file: $($schemeFile.Name)" -ForegroundColor Red
      Write-Host $_.Exception.Message -ForegroundColor Red
    }
  }

  Write-Host "Finished adding schemes from directory: $SchemesDirectory" -ForegroundColor Green

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
    
    # 固定 tab title
    $profile | Add-Member -MemberType NoteProperty -Name "suppressApplicationTitle" -Value $true -Force
  }

  return $Settings
}

$PackageName = "WindowsTerminal"
$WingetPackageID = "Microsoft.WindowsTerminal"

# * 安裝 WindowsTerminal
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID

# * 配置設定檔
$settings = Get-Settings

$ThemesDir = "$PSScriptRoot\themes"
$settings = Add-ThemesFromDirectory -ThemesDirectory $ThemesDir -Settings $settings

$SchemesDir = "$PSScriptRoot\schemes"
$settings = Add-SchemesFromDirectory -SchemesDirectory $SchemesDir -Settings $settings

$settings = Set-AllProfileThemeAndFont -Settings $settings
$settings.theme = "rose-pine"

Save-Settings -Settings $settings
