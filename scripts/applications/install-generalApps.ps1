function get-firefox_ent #Gets most recent version of firefox enterprise from web and installs
{
    function get-LatestFirefoxESRURL {
        [cmdletbinding()]
        [outputtype([String])]
        param(
            [ValidateSet("bn-BD","bn-IN","en-CA","en-GB","en-ZA","es-AR","es-CL","es-ES","es-MX")][string]$culture = "en-US",
            [ValidateSet("win32","win64")][string]$architecture="win32"
        )
 
        # JSON that provide details on Firefox versions
        $uriSource = https://product-details.mozilla.org/1.0/firefox_versions.json
 
        # Read the JSON and convert to a PowerShell object
        $firefoxVersions = (Invoke-WebRequest -uri $uriSource).Content | ConvertFrom-Json
 
        $VersionURL = https://download-installer.cdn.mozilla.net/pub/firefox/releases/$($firefoxVersions.FIREFOX_ESR)/$($architecture)/$($culture)/Firefox%20Setup%20$($firefoxVersions.FIREFOX_ESR).msi
        #Write-Output $VersionURL
        return $VersionURL
        }
 
        function get-LatestFirefoxESRVersion {
        [cmdletbinding()]
        [outputtype([String])]
        <# param(
            [ValidateSet("bn-BD","bn-IN","en-CA","en-GB","en-ZA","es-AR","es-CL","es-ES","es-MX")][string]$culture = "en-US",
            [ValidateSet("win32","win64")][string]$architecture="win32"
 
        ) #> #removed as these params are not being used
 
        # JSON that provide details on Firefox versions
        $uriSource = https://product-details.mozilla.org/1.0/firefox_versions.json
 
        # Read the JSON and convert to a PowerShell object
        $firefoxVersions = (Invoke-WebRequest -uri $uriSource).Content | ConvertFrom-Json
 
        $Version = [Version]$firefoxVersions.FIREFOX_ESR.replace("esr","")
        #Write-Output $Version
        return $Version
        }
 
    $Version = "$(get-LatestFirefoxESRVersion)"
    $PackageName = "Firefox"
    $InstallerType = "msi"
    $Source = "$PackageName" + "." + "$InstallerType"
    $url = "$(get-LatestFirefoxESRURL)"
    #add-content -path .\firefox\ff-version.info -Value "$Version.0"
    Invoke-WebRequest -Uri $url -OutFile .\firefox\$Source
    Write-Output "Firefox binary grab version $version complete, starting install"
    start-process msiexec.exe -ArgumentList "/i $working_dir\firefox\Firefox.msi /quiet" -wait -nonewwindow
 
} #end firefox gather
function get-installRoot
{
    #Grabs InstallRoot from DISA site
    $url = https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/msi/InstallRoot_5.5x64.msi
    $destination = ".\installroot\installroot.msi"
    Invoke-WebRequest -Uri $url -OutFile $destination
    Write-Output "InstallRoot app grab complete, starting install"
    start-process MsiExec.exe -ArgumentList "/i $working_dir\installroot\installroot.msi /quiet /passive" -wait -nonewwindow
 
    write-output "Adding certs to machine store"
    start-process "C:\Program Files\DoD-PKE\InstallRoot\InstallRoot.exe" -ArgumentList "--insert" -wait -nonewwindow
}
function get-rsat #installs RSAT from DISM
{
    write-output "Installing RSAT kit"
    Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
}
function get-chrome_ent #Gets most recent version of chrome enterprise from web and installs
{
    $url = https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi
    $destination = ".\chrome\chrome_enterprise.msi"
    Invoke-WebRequest -Uri $url -OutFile $destination
    Write-Output "Chrome Enterprise update grab complete, starting install"
    start-process MsiExec.exe -ArgumentList "/i $working_dir\chrome\chrome_enterprise.msi /quiet /passive" -wait -nonewwindow
}

###MAIN###
$working_dir = "c:\temp"
 
New-Item $working_dir -ItemType directory
 
set-location $working_dir # Changes to top level directory of the script. Used where elevation was needed and shell restarts in system32
 
#Looks for required directories
 
$req_dirs = @('\firefox', '\chrome', '\edge', '\installroot')
 
foreach ($dir in $req_dirs)
{
    if ((dir_check $working_dir$dir) -eq 0)
    {
        Write-Output "$working_dir$dir exists"
        continue
    }
    else
    {
        Write-Output "creating directory $dir"
        New-Item $working_dir$dir -ItemType directory
        continue
    }
}

get-chrome_ent
get-firefox_ent
get-installRoot
get-rsat