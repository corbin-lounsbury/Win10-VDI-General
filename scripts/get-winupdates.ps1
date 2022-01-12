$ProgressPreference
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PSWindowsUpdate -Force

#Import-Module PSWindowsUpdate -ErrorAction Stop

#install-windowsupdate -AcceptAll -IgnoreReboot