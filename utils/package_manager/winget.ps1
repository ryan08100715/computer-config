function Install-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id
  )

  winget install --id $Id
}

function UnInstall-MyWinGetPackage {
  param (
    [Parameter(Mandatory)]
    [string]$Id
  )

  winget uninstall --id $Id
}
