$packageName = 'workrave'
$installerType = 'exe'
$url = 'https://github.com/rcaelers/workrave/releases/download/v1_10_45/workrave-win32-v1.10.45.exe'
$silentArgs = '/verysilent /norestart'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes
