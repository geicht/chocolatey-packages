$ErrorActionPreference  = 'Stop';
$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64                  = 'https://download.docker.com/win/static/stable/x86_64/docker-20.10.13.zip'
$checksum64             = 'f18382ae665d75b1c31b1cc349bfd7d136cb29f67ea688849f2f31ed52e18f5f'
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
