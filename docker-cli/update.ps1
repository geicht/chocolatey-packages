import-module au

$to_natural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20) }) }
$releases = "https://download.docker.com/win/static/stable/x86_64/"

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $regex = '.zip$'

    $archive_name = $download_page.links | Where-Object href -match $regex | Select-Object -expand href | Sort-Object $to_natural | Select-Object -Last 1
    $archive_url = "$releases" + "$archive_name"
    $archive_path = ".\bin\$archive_name"
    $version = $archive_name -split '-|.zip' | Select-Object -First 1 -Skip 1

    $release_notes = "https://docs.docker.com/engine/release-notes/#$($version.replace('.', '') )"

    return @{
        Version = $version;
        URL64 = $archive_url;
        Archive64 = $archive_path;
        ReleaseNotes = $release_notes;
    }
}

function global:au_BeforeUpdate() {
    New-Item -ItemType Directory -Force -Path ".\bin\"
    Start-BitsTransfer -Source $Latest.URL64 -Destination $Latest.Archive64
    7z e $Latest.Archive64 -obin "docker\docker.exe" -aoa
    Remove-Item $Latest.Archive64

    $Latest.ChecksumType64 = 'sha256'
    $Latest.Checksum64 = Get-FileHash ".\bin\docker.exe" -Algorithm $Latest.ChecksumType64 | ForEach-Object Hash
}

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x64:).*" = "`${1} $( $Latest.URL64 )"
            "(?i)(checksum64:).*" = "`${1} $( $Latest.Checksum64 )"
        }

        ".\$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$( $Latest.ReleaseNotes )`$2"
        }

        ".\README.md" = @{
            "(\(https://community.chocolatey.org/packages/docker-cli)/.*?(\)$)" = "`${1}/$( $Latest.Version )`$2"
        }
    }
}

update -ChecksumFor none
