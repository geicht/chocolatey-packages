$packageToolsDir    = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
. $(Join-Path $packageToolsDir "helpers.ps1")
$packageParameters  = Get-PackageParameters
$silentArgs         = Get-SilentArgs($packageParameters)
$installerName      = 'Mambaforge-24.3.0-0-Windows-x86_64.exe'
$installerPath      = Join-Path $packageToolsDir $installerName

$packageArgs = @{
    PackageName     = 'mambaforge'
    FileType        = 'EXE'
    File64          = $installerPath
    SilentArgs      = $silentArgs
    ValidExitCodes  = @(0)
}
Install-ChocolateyInstallPackage @packageArgs
