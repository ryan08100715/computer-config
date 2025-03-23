#!/usr/bin/env pwsh

. $PSScriptRoot\output.ps1

function IsAdministrator {
  $currentPrincipal = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $windowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($currentPrincipal)
  return $windowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Update-EnvPath {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
  Write-MySuccess -Icon "環境變數已更新"
}

function EnsureAdminRun {
  if (-not (IsAdministrator)) {
    Write-MyError "腳本沒有以管理員權限執行，請以管理員身分重新執行！"
    exit
  }
}

function New-TemporaryDirectory {
  $parent = [System.IO.Path]::GetTempPath()
  [string] $name = [System.Guid]::NewGuid()
  New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

function Get-StartupDirectoryPath {
  return "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
}

function Get-MyAppsDirectoryPath {
  return "$env:USERPROFILE\Apps"
}

function CheckInstalledByWingetId {
  param (
    [Parameter(Mandatory)]
    [string]$WingetID
  )

  if (winget list | Select-String -Pattern $WingetID) {
    return $true
  }
  return $false
}

function Install-PackageByWinget {
  param (
    [Parameter(Mandatory)]
    [string]$WingetID,
    [ValidateNotNullOrEmpty()]
    [boolean]$interactive = $false
  )

  if (-not (CheckInstalledByWingetId $WingetID)) {
    if ($interactive) {
      winget install -i --id $WingetID
    }
    else {
      winget install --id $WingetID
    }
  }
}

function Test-CommandExist {
  param (
    [Parameter(Mandatory)]
    [string]$Command
  )

  return Get-Command $Command -ErrorAction SilentlyContinue
}

function Exit-WhenCommandNotExist {
  param(
    [Parameter(Mandatory)]
    [string[]]$Commands
  )

  foreach ($cmd in $Commands) {
    if (-not (Test-CommandExist $cmd)) {
      Write-MyError "尚未安裝依賴: $cmd"
      exit 1
    }
  }
}

function Get-MyOSInfo {
  if ($IsWindows) {
    $osVersion = (Get-CimInstance -ClassName Win32_OperatingSystem).Version

    return [PSCustomObject]@{
      OS      = 'windows'
      Version = $osVersion
    }
  }
  elseif ($IsLinux) {
    $osInfo = Get-Content /etc/os-release | ConvertFrom-StringData

    return [PSCustomObject]@{
      OS      = $osInfo.ID
      Version = $osInfo.VERSION_ID.Trim('"')
    }
  }
  elseif ($IsMacOS) {
    return [PSCustomObject]@{
      OS      = 'macos'
      Version = 'unknown'
    }
  }
  else {
    Write-MyError -Icon "無法辨識作業系統"
    exit 1
  }
}
