function Get-GithubLatestReleaseResponse {
  param (
    [Parameter(Mandatory)]
    [string]$RepoName
  )
  
  $githubApiUrl = "https://api.github.com/repos/$RepoName/releases/latest"

  $response = Invoke-RestMethod -Uri $githubApiUrl
  
  return $response
}