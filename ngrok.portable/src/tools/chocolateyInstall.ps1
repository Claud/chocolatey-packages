#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'ngrok.portable' # arbitrary name for the package, used in messages
$url = 'https://ngrok.com/download' # download url
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try { #error handling is only necessary if you need to do anything in addition to/instead of the main helpers
    $chocTempDir = Join-Path $env:TEMP "chocolatey"
    $tempDir = Join-Path $chocTempDir "$packageName"
    if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
	
	$indexFile = Join-Path $tempDir "$($packageName).html"
	Get-ChocolateyWebFile "$packageName" "$indexFile" "$url"
	
	write-host "[$packageName] Trying to find a link to a ngrok."
	
    $contentIndexFile = Get-Content "$indexFile"
	if("$contentIndexFile" -match '<tr[^>]+?id="dl-windows-386">(?:.|\s)*?<a[^>]+?href="(http[s]?:\/\/api\.equinox\.io[^"]+?)"') {
		$downloadeUrl = $matches[1]
		$downloadeUrl = $downloadeUrl.Replace("&amp;","&") 
		write-host "[$packageName] Link is found. $downloadeUrl"
		
		Install-ChocolateyZipPackage "$packageName" "$downloadeUrl" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	} else {
		write-host "[$packageName] Link is not found."
		throw
	}
	
    Write-ChocolateySuccess "$packageName"
} catch {
    Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
    throw
}

Remove-Item "$indexFile"