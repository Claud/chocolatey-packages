$packageName = 'yandexdisk'
$installerType = 'exe'
$url = 'https://disk.yandex.ru/download/link'
$silentArgs = '/silent'
$validExitCodes = @(0)

$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "$packageName"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$indexFile = Join-Path $tempDir "$($packageName).html"
Get-ChocolateyWebFile "$packageName" "$indexFile" "$url"
write-host "[$packageName] Trying to find a link to a '.exe' file."
$contentIndexFile = Get-Content "$indexFile"

if("$contentIndexFile" -match '"YandexDiskSetupPackRu.exe"\s*:\s*"(http[s]?://downloader\.[^"]+?)"') {
    $downloadeUrl = $matches[1];
    write-host "[$packageName] Link is found. $downloadeUrl"
    Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$downloadeUrl"  -validExitCodes $validExitCodes
} else {
    write-host "[$packageName] Link is not found."
    throw
}

Remove-Item "$indexFile"