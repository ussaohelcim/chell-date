$file = Get-Content (Join-Path ($PSScriptRoot) ".." ("src","pdxinfo"))

$gameName = ($file | Select-String -Pattern 'bundleID=').ToString().replace("bundleID=","").Replace("com.NILCO.","")  

$version = ($file | Select-String -Pattern 'buildNumber=').ToString().replace("buildNumber=","")
$fileName = "$gameName-$version"
$dist = (Join-Path ($PSScriptRoot) ".." ($fileName))
$src = (Join-Path ($PSScriptRoot) ".." ("src"))

& pdc $src $dist
& 7z a -tzip  "$fileName.pdx.zip" "$fileName.pdx"
