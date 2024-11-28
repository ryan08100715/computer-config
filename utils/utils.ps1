#!/usr/bin/env pwsh

function Write-MySuccess {
  param (
    [Parameter(Mandatory)]
    [string]$Message
  )

  $greenCheck = @{
    Object          = [Char]10003
    ForegroundColor = 'Green'
    NoNewLine       = $true
  }
  
  Write-Host @greenCheck
  Write-Host " $Message"
}

function Write-MyWarning {
  param (
    [Parameter(Mandatory)]
    [string]$Message
  )

  $yellowExclamation = @{
    Object          = [Char]33
    ForegroundColor = 'Yellow'
    NoNewLine       = $true
  }
  
  Write-Host @yellowExclamation
  Write-Host " $Message"
}

function Write-MyError {
  param (
    [Parameter(Mandatory)]
    [string]$Message
  )

  $redCross = @{
    Object          = [Char]10007
    ForegroundColor = 'Red'
    NoNewLine       = $true
  }
  
  Write-Host @redCross
  Write-Host " $Message"
}

function Write-MySecondList {
  param (
    [Parameter(Mandatory)]
    [string]$Message
  )
  
  Write-Host "  - $Message"
}

function IsAdministrator {
  $currentPrincipal = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $windowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($currentPrincipal)
  return $windowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Update-EnvPath {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
  Write-Host "環境 PATH 已更新" -ForegroundColor Green
}

function EnsureAdmin {
  if (-not (IsAdministrator)) {
    Write-MyError "腳本沒有以管理員權限執行，請以管理員身分重新執行！"
    exit
  }  
}
function GetGithubAssetDownloadUrl {
  param (
    [Parameter(Mandatory)]
    [string]$RepoName,
    [Parameter(Mandatory)]
    [string]$AssetRegex
  )
  
  $github_api_url = "https://api.github.com/repos/$RepoName/releases/latest"

  $response = Invoke-RestMethod -Uri $github_api_url
  $assets = $response.assets | Where-Object { $_.name -match $AssetRegex }

  Write-Host $assets.count

  if ($assets.count -eq 0) {
    return false
  }

  return $assets[0].browser_download_url
}

function New-TemporaryDirectory {
  $parent = [System.IO.Path]::GetTempPath()
  [string] $name = [System.Guid]::NewGuid()
  New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

function Get-Startup-Directory {
  return "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
}

function CheckInstalledByWingetId {
  param (
    [Parameter(Mandatory)]
    [string]$WingetID
  )

  if (winget list --id $WingetID | Select-String -Pattern $WingetID) {
    return $true
  }
  return $false
}

if (CheckInstalledByWingetId "AutoHotkey.AutoHotkey1") {
  Write-Host "套件 - AutoHotkey 已經安裝"
}
else {
  Write-Host "尚未安裝 AutoHotkey, 即將開始安裝"
}