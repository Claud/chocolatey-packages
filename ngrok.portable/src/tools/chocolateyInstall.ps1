$packageName = 'ngrok.portable'
$url = 'https://ngrok.com/download'
$validExitCodes = @(0)

$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "$packageName"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$indexFile = Join-Path $tempDir "$($packageName).html"
Get-ChocolateyWebFile "$packageName" "$indexFile" "$url"

write-host "[$packageName] Trying to find a link to a ngrok."

$contentIndexFile = Get-Content "$indexFile"
if ((Get-ProcessorBits 64) -and !$env:chocolateyForceX86) {
    $regxp = 'id="dl-windows-amd64"(?:.|\s)*?<a[^>]+?href="(http[s]?:\/\/[^"]*?)"'
} else {
    $regxp = 'id="dl-windows-386"(?:.|\s)*?<a[^>]+?href="(http[s]?:\/\/[^"]*?)"'
}
if("$contentIndexFile" -match "$regxp") {
    $downloadeUrl = $matches[1]
    $downloadeUrl = $downloadeUrl.Replace("&amp;","&") 
    write-host "[$packageName] Link is found. $downloadeUrl"
    
    Install-ChocolateyZipPackage "$packageName" "$downloadeUrl" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
} else {
    write-host "[$packageName] Link is not found."
    throw
}

Remove-Item "$indexFile" -Recurse