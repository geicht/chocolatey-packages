$executableDir      = 'C:\ProgramData\Docker\cli-plugins\'
$executablePath     = Join-Path $executableDir 'docker-compose.exe'

$dockerPath         = Split-Path -Path $executableDir -Parent

# delete executable if it exists
if (Test-Path -Path $executablePath) {
    Remove-Item -Path $executablePath -Force
}

# delete plugin directory if empty
if ($null -eq (Get-ChildItem -Path $executableDir)) {
    Remove-Item -Path $executableDir -Force
}

# delete docker directory if empty
if ($null -eq (Get-ChildItem -Path $dockerPath)) {
    Remove-Item -Path $dockerPath -Force
}
