& ([scriptblock]::Create((irm "https://debloat.raphi.re/"))) -RemoveApps `
  -DisableDVR `
  -DisableTelemetry `
  -DisableSuggestions `
  -DisableLockscreenTips `
  -DisableBing `
  -DisableCopilot `
  -DisableRecall `
  -DisableDesktopSpotlight `
  -EnableDarkMode `
  -RevertContextMenu `
  -DisableMouseAcceleration `
  -DisableStickyKeys `
  -DisableFastStartup `
  -DisableSettings365Ads `
  -HideIncludeInLibrary `
  -HideGiveAccessTo `
  -HideShare `
  -ClearStart `
  -DisableStartRecommended `
  -DisableStartPhoneLink `
  -HideSearchTb `
  -HideTaskview `
  -HideChat `
  -DisableWidgets `
  -EnableEndTask `
  -ExplorerToThisPC `
  -ShowHiddenFolders `
  -ShowKnownFileExt `
  -HideHome `
  -HideGallery `
  -HideOnedrive `
  -Hide3dObjects `
  -HideMusic
