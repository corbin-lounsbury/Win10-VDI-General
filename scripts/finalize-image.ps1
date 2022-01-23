
#Remove default desktop layout
Remove-item C:\Users\Public\Desktop\* -Force

# Removes local admin autologon
Set-ItemProperty -path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Value 0 -Force