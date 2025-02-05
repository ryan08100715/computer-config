#!/usr/bin/env pwsh

function Write-MyInfo {
  param (
    [string]$Message
  )

  Write-Host $Message
}

function Write-MySuccess {
  param (
    [string]$Message,
    [switch]$Icon = $false
  )

  $greenCheck = @{
    Object          = [Char]10003
    ForegroundColor = 'Green'
    NoNewLine       = $true
  }

  if ($Icon) {
    Write-Host @greenCheck
    Write-Host -NoNewline " "
  }
  
  Write-Host -ForegroundColor Green $Message
}

function Write-MyWarning {
  param (
    [string]$Message,
    [switch]$Icon = $false
  )

  $yellowWarning = @{
    Object          = [Char]9888
    ForegroundColor = 'Yellow'
    NoNewLine       = $true
  }

  if ($Icon) {
    Write-Host @yellowWarning
    Write-Host -NoNewline " "
  }

  Write-Host -ForegroundColor Yellow $Message
}

function Write-MyError {
  param (
    [string]$Message,
    [switch]$Icon = $false
  )

  $redCross = @{
    Object          = [Char]10007
    ForegroundColor = 'Red'
    NoNewLine       = $true
  }

  if ($Icon) {
    Write-Host @redCross
    Write-Host -NoNewline " "
  }
  
  Write-Host -ForegroundColor Red $Message
}
