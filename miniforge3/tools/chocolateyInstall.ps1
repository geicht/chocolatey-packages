$packageToolsDir    = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
. $(Join-Path $packageToolsDir "helpers.ps1")
$packageParameters  = Get-PackageParameters
$silentArgs         = Get-SilentArgs($packageParameters)
$installerName      = 'Miniforge3-25.3.0-3-Windows-x86_64.exe'
$installerPath      = Join-Path $packageToolsDir $installerName

$packageArgs = @{
    PackageName     = 'miniforge3'
    FileType        = 'EXE'
    File64          = $installerPath
    SilentArgs      = $silentArgs
    ValidExitCodes  = @(0)
}
Install-ChocolateyInstallPackage @packageArgs
