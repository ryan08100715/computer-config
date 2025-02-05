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

function Get-Apps-Directory {
  return "$env:USERPROFILE\Apps"
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
