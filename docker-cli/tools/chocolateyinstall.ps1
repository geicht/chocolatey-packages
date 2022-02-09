$ErrorActionPreference  = 'Stop';
$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64                  = ''
$checksum64             = ''
$checksumType64         = 'sha256'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url64bit       = $url64

  softwareName   = 'docker-cli'
  specificFolder = 'docker/docker.exe'

  checksum64     = $checksum64
  checksumType64 = $checksumType64

}

Install-ChocolateyZipPackage @packageArgs
