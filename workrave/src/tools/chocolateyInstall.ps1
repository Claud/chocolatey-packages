$packageName = 'workrave'
$installerType = 'exe'
$url = 'http://downloads.sourceforge.net/project/workrave/workrave/1.10/workrave-win32-v1.10-installer.exe?r=http%3A%2F%2Fwww.workrave.org%2Fdownload%2F&ts=1436743477&use_mirror=vorboss'
$silentArgs = '/verysilent /norestart'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes