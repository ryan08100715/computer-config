#!/usr/bin/env pwsh

param (
  [Parameter()]
  [ValidateSet("winget", "choco")]
  [string]$WinPackageManager = "winget"
)

function Install-JetbrainsMonoNerdFont {
  & "$PSScriptRoot\..\..\apps\fonts\jetbrains_mono_nerd_font\install.ps1"
}

Install-JetbrainsMonoNerdFont
