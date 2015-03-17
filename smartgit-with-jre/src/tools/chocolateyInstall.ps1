$packageName = 'smartgit-with-jre'
$installerType = 'exe'
$url = 'http://www.syntevo.com/downloads/smartgit/smartgit-win32-setup-jre-6_5_6.zip'
$silentArgs = '/verysilent /norestart'
$validExitCodes = @(0)

$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "$packageName"
$tempDir = Join-Path $tempDir "unzip"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

Install-ChocolateyZipPackage "$packageName" "$url" "$tempDir"
$exeFilePath = get-childitem $tempDir -recurse -include *.$installerType | select -First 1
Install-ChocolateyInstallPackage "$packageName" "$installerType" "$silentArgs" "$exeFilePath"

Remove-Item "$tempDir" -Recurse
