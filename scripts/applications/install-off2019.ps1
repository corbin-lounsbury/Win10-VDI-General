function install-office {
    $url = "https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_14527-20178.exe"
    $destination = "c:\temp\office"
    write-output "Creating temporary directory"
    new-item -path $destination -ItemType Directory -Force
    Invoke-WebRequest -Uri $url -OutFile $destination
    write-output "Office installation starting"
    #Start-Process
}

install-office