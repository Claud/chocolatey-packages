#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'smartgit-with-jre' # arbitrary name for the package, used in messages
$installerType = 'exe' #only one of these: exe, msi, msu
$url = 'http://www.syntevo.com/download/smartgithg/smartgithg-win32-setup-jre-5_0_9.zip' # download url
$silentArgs = '/verysilent /norestart' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
    $toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    Install-ChocolateyZipPackage "$packageName" "$url" $toolsDir

    $exeFilePath = get-childitem $toolsDir -recurse -include *.$installerType | select -First 1
    Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" "$exeFilePath"
    
    $logFilePath = get-childitem $toolsDir -recurse -include *.txt | select -First 1
    Remove-Item "$exeFilePath"
    Remove-Item "$logFilePath"
    
    Write-ChocolateySuccess "$packageName"
} catch {
    Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
    throw
}
