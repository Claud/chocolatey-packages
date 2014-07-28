#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'yandexdisk' # arbitrary name for the package, used in messages
$installerType = 'exe' #only one of these: exe, msi, msu
$url = 'http://disk.yandex.ru/download/YandexDiskSetupPack.exe/' # download url
$silentArgs = '/silent' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "$packageName"
    if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
	
	$indexFile = Join-Path $tempDir "$($packageName).html"
	Get-ChocolateyWebFile "$packageName" "$indexFile" "$url"
	write-host "[$packageName] Trying to find a link to a '.exe' file."
    $contentIndexFile = Get-Content "$indexFile"
	$temp = $contentIndexFile -match '<a[^>]href="(http[s]?://downloader\.disk\.[^"]+?)"'
	
	if($matches[1]) {
		$downloadeUrl = $matches[1];
		write-host "[$packageName] Link is found. $downloadeUrl"
		Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$downloadeUrl"  -validExitCodes $validExitCodes
	} else {
		write-host "[$packageName] Link is not found."
		throw
	}
    
    Remove-Item "$indexFile"
    
    Write-ChocolateySuccess "$packageName"
} catch {
    Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
    throw
}