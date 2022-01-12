function install-office {
    $url = "https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_14527-20178.exe"
    $destinationPath = "c:\temp\office"
    $odtArchive = "$destinationPath\ODTarchive.exe"
    write-output "Creating temporary directory"
    new-item -path $destinationPath -ItemType Directory -Force
    Invoke-WebRequest -Uri $url -OutFile $odtArchive
    Write-Output "Expanding ODT Archive"
    start-process .\ODTarchive.exe -ArgumentList "/extract:$destinationPath /quiet /passive" -Wait -NoNewWindow
    write-output "Office installation starting"
    Start-Process $destinationPath\setup.exe -ArgumentList "/configure a:\Office19Configuration.xml" -Wait -NoNewWindow
}

install-office