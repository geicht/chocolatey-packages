import-module au

$name64     = "docker-credential-wincred.exe"
$releaseUrl = "https://api.github.com/repos/docker/docker-credential-helpers/releases/latest"

function global:au_GetLatest {
    $headers = @{}
    if (Test-Path Env:\github_api_key) {
        $headers["Authorization"] = "token $Env:github_api_key"
    }

    $jsonAnswer = Invoke-RestMethod `
        -Uri $releaseUrl `
        -Headers $headers `
        -UseBasicParsing

    $jsonAnswer.assets | Where { $_.name -Match "^docker-credential-wincred-$($jsonAnswer.tag_name).windows-amd64.exe$" } | ForEach-Object {
        $url64 = $_.browser_download_url
    }

    $version = $jsonAnswer.tag_name.replace("v", "")

    $release_notes = $jsonAnswer.html_url

    return @{
        Version = $version;
        URL64 = $url64;
        Name64 = $name64;
        ReleaseNotes = $release_notes;
    }
}

function global:au_BeforeUpdate() {
    New-Item -ItemType Directory -Force -Path ".\bin\"
    $executablePath = Join-Path ".\bin\" $Latest.Name64
    Start-BitsTransfer -Source $Latest.URL64 -Destination $executablePath

    $Latest.ChecksumType64 = 'sha256'
    $Latest.Checksum64 = Get-FileHash $executablePath -Algorithm $Latest.ChecksumType64 | ForEach-Object Hash
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
            "(\(https://community.chocolatey.org/packages/docker-credential-wincred)/.*?(\)$)" = "`${1}/$( $Latest.Version )`$2"
        }
    }
}

update -ChecksumFor none
