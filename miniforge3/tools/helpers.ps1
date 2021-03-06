function Get-SilentArgs($packageParameters) {
    $toolsDir = Get-ToolsLocation

    if (!$packageParameters['InstallationType']) {
        $InstallationType = 'AllUsers'
    }
    else {
        if ($packageParameters['InstallationType'] -notin 'AllUsers', 'JustMe') {
            throw "Value for InstallationType not recognised: only `'AllUsers`' or `'JustMe`' are valid"
        }
        else {
            $InstallationType = $packageParameters['InstallationType']
        }
    }

    if (!$packageParameters['RegisterPython']) {
        $RegisterPython = '1'
    }
    else {
        if ($packageParameters['RegisterPython'] -notin '0', '1') {
            throw "Value for RegisterPython not recognised: only `'0`' or `'1`' are valid"
        }
        else {
            $RegisterPython = $packageParameters['RegisterPython']
        }
    }

    if (!$packageParameters['AddToPath']) {
        $AddToPath = '0'
    }
    else {
        if ($packageParameters['AddToPath'] -notin '0', '1') {
            throw "Value for AddToPath not recognised: only `'0`' or `'1`' are valid"
        }
        else {
            $AddToPath = $packageParameters['AddToPath']
        }
    }

    if (!$packageParameters['D']) {
        if ($InstallationType -eq 'JustMe') {
            $D = Join-Path $Env:LOCALAPPDATA 'miniforge3'
        }
        else {
            $D = Join-Path $toolsDir 'miniforge3'
        }
    }
    else {
        if (!(Test-Path -IsValid $packageParameters['D'])) {
            throw "Value for D ($($packageParameters['D'])) is not a valid directory path"
        }
        else {
            $D = $packageParameters['D']
        }
    }

    Write-Host "miniforge3 will be installed for $(if ($InstallationType -eq "AllUsers") { "all users" } else { "current user" })."
    Write-Host "miniforge3 python will $(if ($RegisterPython -ne "1") { "not " })be registered as the system's default."
    Write-Host "miniforge3 directories will $(if ($AddToPath -ne "1") { "not " })be added to path."
    Write-Host "miniforge3 will be installed to `'$D`'."
    Write-Host ""

    return "/S /InstallationType=$InstallationType /RegisterPython=$RegisterPython /AddToPath=$AddToPath /D=$D"
}
