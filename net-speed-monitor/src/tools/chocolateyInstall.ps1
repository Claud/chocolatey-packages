#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'net-speed-monitor' # arbitrary name for the package, used in messages
$installerType = 'msi' #only one of these: exe, msi, msu
$url = 'http://www.floriangilles.com/download-netspeedmonitor-2-5-4-0-x86' # download url
$url64 = 'http://www.floriangilles.com/download-netspeedmonitor-2-5-4-0-x64' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '/quiet' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights

# Set compatibility mode to Windows 7 if operating system is Windows 8 or higher.
$WindowsVersion = (Get-WmiObject -class Win32_OperatingSystem).Version
if ($WindowsVersion -ge "6.2.9200") {
    if (-not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" -Name Layers
    }
    New-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -propertyType String -Name "$env:temp\chocolatey\$packageName\$packageName`Install.$installerType" -value "~ WIN7RTM"
    Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
    
    # Delete compatibility mode for ext2fsd installer, because it’s not needed anymore
    Remove-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -Name "$env:temp\chocolatey\$packageName\$packageName`Install.$installerType"
} else {
    Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
}