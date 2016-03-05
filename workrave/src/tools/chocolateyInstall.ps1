$packageName = 'workrave'
$installerType = 'exe'
$url = 'http://downloads.sourceforge.net/project/workrave/workrave/1.10/workrave-win32-v1.10-installer.exe?r=&ts=1457189903&use_mirror=netix'
$silentArgs = '/verysilent /norestart'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes