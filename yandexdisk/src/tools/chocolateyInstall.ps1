#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'yandexdisk' # arbitrary name for the package, used in messages
$installerType = 'exe' #only one of these: exe, msi, msu
$url = 'https://downloader.disk.yandex.ru/share/26833500ea129074ec8998a52fab7c64/5375fa55/qj7-HmnYJR-X8WCmW5r6Z2972K5FexFNUae-LGyLpCzf_m0pmy5NOdO0O7P-IzufxKJzGjZaXHe6p7uDI8xWcA%3D%3D?uid=0&filename=YandexDiskSetupRu.exe&disposition=attachment&hash=&limit=0&content_type=application%2Fx-msdownload&fsize=1002272&hid=0a355dc4ffd98c48b6fd5325db8c7f0c&media_type=executable' # download url
$silentArgs = '/silent' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

# main helpers - these have error handling tucked into them already
# installer, will assert administrative rights
# if removing $url64, please remove from here
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
# download and unpack a zip file