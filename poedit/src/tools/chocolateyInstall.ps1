$packageName = 'poedit'
$installerType = 'exe'
$url = 'https://poedit.r.worldssl.net/Poedit-1.7.6-setup.exe'
$silentArgs = '/verysilent /norestart'
$validExitCodes = @(0)


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes