$binRoot = Get-BinRoot
$goLangRoot = join-path $binRoot "go"

if (Test-Path $goLangRoot) {
    Remove-Item "$goLangRoot" -Recurse
}