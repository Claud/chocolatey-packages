$packageName = 'poedit'
$installerType = 'exe'
$url = 'https://download.poedit.net/Poedit-1.8.2-setup.exe'
$silentArgs = '/verysilent /norestart'
$validExitCodes = @(0)


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes