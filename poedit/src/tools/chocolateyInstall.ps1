$packageName = 'poedit'
$installerType = 'exe'
$url = 'http://poedit.net/dl/Poedit-1.7.4-setup.exe'
$silentArgs = '/verysilent /norestart'
$validExitCodes = @(0)


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes