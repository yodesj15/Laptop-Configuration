$Path = $env:TEMP
$Installer = "chrome_installer.exe"
Invoke-WebRequest "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile "$Path\$Installer"

Start-Process -FilePath "$Path\$Installer" -Args "/silent /install" -Verb RunAs -Wait
Start-Process -FilePath "chrome" -Args "--make-default-browser" -Wait
Start-Process -FilePath "chrome" -Args "--pin-to-taskbar" -Wait

Remove-Item "$Path\$Installer"
