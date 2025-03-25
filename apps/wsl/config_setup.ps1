#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1

Copy-Item -Force -Path "$PSScriptRoot\config\.wslconfig" -Destination "$HOME\.wslconfig"
Write-MySuccess -Icon "放置 .wslconfig 到: $HOME\.wslconfig"

Write-MyInfo ""
