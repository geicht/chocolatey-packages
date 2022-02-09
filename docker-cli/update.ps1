import-module au

$to_natural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20) }) }
$releases = "https://download.docker.com/win/static/stable/x86_64/"

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $regex = '.zip$'
    $filename = $download_page.links | ? href -match $regex | select -expand href  | Sort-Object $to_natural | select -Last 1
    $url = "$releases" + "$filename"
    $version = $filename -split '-|.zip' | select -First 1 -Skip 1
    return @{
        Version = $version;
        URL64 = $url;
        ChecksumType64 = 'sha256';
        ReleaseNotes = "https://docs.docker.com/engine/release-notes/#$($version.replace('.', '') )"
    }
}


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$( $Latest.URL64 )'"           #1
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$( $Latest.Checksum64 )'"      #2
        }

        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x64:).*" = "`${1} $( $Latest.URL64 )"
            "(?i)(checksum64:).*" = "`${1} $( $Latest.Checksum64 )"
        }

        ".\$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$( $Latest.ReleaseNotes )`$2"
        }
    }
}

update -ChecksumFor 64
