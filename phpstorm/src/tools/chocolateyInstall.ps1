$packageName = 'phpstorm'
$installerType = 'exe'
$url = 'http://download.jetbrains.com/webide/PhpStorm-9.0.exe'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes