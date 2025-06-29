#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\utils\output.ps1
. $PSScriptRoot\..\..\utils\file_system.ps1

Copy-MyItem -Target "$PSScriptRoot\config\.wslconfig" -Destination "$HOME\.wslconfig" -SuppressOutput
Write-MySuccess -Icon "放置 .wslconfig 到: $HOME\.wslconfig"

Write-MyInfo ""
