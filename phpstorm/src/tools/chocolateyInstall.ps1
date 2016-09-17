$packageName = 'phpstorm'
$installerType = 'exe'
$url = 'https://download.jetbrains.com/webide/PhpStorm-2016.2.1.exe'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
