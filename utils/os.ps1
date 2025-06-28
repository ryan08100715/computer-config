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
    return [PSCustomObject]@{
      OS      = 'unknown'
      Version = 'unknown'
    }
  }
}
