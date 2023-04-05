import-module au

$name64     = "docker-compose.exe"
$releaseUrl = "https://api.github.com/repos/docker/compose/releases/latest"

function global:au_GetLatest {
    $headers = @{}
    if (Test-Path Env:\github_api_key) {
        $headers["Authorization"] = "token $Env:github_api_key"
    }

    $jsonAnswer = Invoke-RestMethod `
        -Uri $releaseUrl `
        -Headers $headers `
        -UseBasicParsing

    $jsonAnswer.assets | Where { $_.name -Match "^docker-compose-windows-x86_64.exe$" } | ForEach-Object {
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
    $executablePath = Join-Path ".\tools\" $Latest.Name64
    Start-BitsTransfer -Source $Latest.URL64 -Destination $executablePath

    Verify-Checksum
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
            "(\(https://community.chocolatey.org/packages/docker-compose)/.*?(\)$)" = "`${1}/$( $Latest.Version )`$2"
        }
    }
}

function Verify-Checksum() {
    $Latest.ChecksumType64 = 'sha256'
    $checksumUrl ="$($Latest.URL64).$($Latest.ChecksumType64)"
    $executablePath = Join-Path ".\tools\" $Latest.Name64

    $response = Invoke-WebRequest -Uri $checksumUrl -UseBasicParsing
    $responseText = [System.Text.Encoding]::UTF8.GetString($response.Content)

    $remoteChecksum64 = $($responseText -split " ")[0].ToUpper()
    $localChecksum64 = $(Get-FileHash -Path $executablePath -Algorithm $Latest.ChecksumType64 | ForEach-Object Hash).ToUpper()

    if ($remoteChecksum64 -ne $localChecksum64) {
        throw "Remote checksum `'$remoteChecksum64`' doesn't match local checksum `'$localChecksum64`'."
    } else {
        Write-Host "Remote checksum matches local checksum (`'$localChecksum64`')."
    }

    $Latest.Checksum64 = $localChecksum64
}

update -ChecksumFor none
