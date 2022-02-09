$ErrorActionPreference  = 'Stop';
$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64                  = 'https://download.docker.com/win/static/stable/x86_64/docker-20.10.12.zip'
$checksum64             = 'bd3775ada72492aa1f3c2edb3e81663bd128b9d4f6752ef75953a6af7c219c81'
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
