#!/usr/bin/env pwsh

. "$PSScriptRoot/output.ps1"

function Get-GithubLatestReleaseResponse {
  param (
    [Parameter(Mandatory)]
    [string]$RepoName
  )

  $githubApiUrl = "https://api.github.com/repos/$RepoName/releases/latest"

  $response = Invoke-RestMethod -Uri $githubApiUrl

  return $response
}

function Get-GithubFileMetadata {
  param(
    [Parameter(Mandatory)]
    [string]$RepoName,
    [Parameter(Mandatory)]
    [string]$FileRegex
  )

  $response = Get-GithubLatestReleaseResponse -RepoName $RepoName

  $assets = $response.assets | Where-Object { $_.name -match $FileRegex }
  if ($assets.count -eq 0) {
    Write-MyError -Icon "無法獲取下載 URL"
    exit 1
  }

  return [PSCustomObject]@{
    Version     = $response.tag_name
    DownloadUrl = $assets[0].browser_download_url
  }
}
