$packageToolsDir        = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$executablePath         = Join-Path $packageToolsDir 'docker-compose.exe'

$executableTargetDir    = 'C:\ProgramData\Docker\cli-plugins\'
$executableTargetPath   = Join-Path $executableTargetDir 'docker-compose.exe'

# create plugin directory if it doesn't exist
if (-not (Test-Path -Path $executableTargetDir)) {
    $null = New-Item -Path $executableTargetDir -ItemType Directory
}

# move executable
#Move-Item -Path $executablePath -Destination $executableTargetPath -Force

# copy executable
Copy-Item -Path $executablePath -Destination $executableTargetPath -Force
