New-SmbMapping -LocalPath "Z:" -RemotePath "\\blap-sto3\isovol1" -persistent $true -username Guest -password "password"
new-item c:\temp\horizon -ItemType Directory -Force
copy-item -path "z:\VMWare\horizon 8\2111\VMware-Horizon-Agent-x86_64-2111.1-8.4.0-19066669.exe" -Destination c:\temp\horizon

start-process "c:\temp\horizon\VMware-Horizon-Agent-x86_64-2111.1-8.4.0-19066669.exe" -argumentlist '/s /v "/qn VDM_VC_MANAGED_AGENT=1 SUPPRESS_RUNONCE_CHECK=1 ADDLOCAL=Core,SVIAgent,ThinPrint,USB,RTAV"' -wait -nonewwindow