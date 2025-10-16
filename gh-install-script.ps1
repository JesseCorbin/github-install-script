[CmdletBinding()]
<#
    .EXAMPLE
    .\gh-install-script.ps1 -repoOwner notepad-plus-plus -repoName notepad-plus-plus -filter x64.exe
    https://github.com/notepad-plus-plus/notepad-plus-plus/releases/tag/v8.8.6
#>
param (
    [Parameter(Mandatory=$true)]
    [string]
    $repoOwner,
    [Parameter(Mandatory=$true)]
    [string]
    $repoName,
    [Parameter(Mandatory=$true)]
    [string]
    $filter
)

$apiUrl = "https://api.github.com/repos/$repoOwner/$repoName/releases/latest"

# Get release info
$content = Invoke-RestMethod -Uri $apiUrl

# Find the asset URL matching your filename
$downloadUrl = $content.assets | Where-Object { $_.name -like "*$filter" } | Select-Object -ExpandProperty browser_download_url

# Download the file to current directory
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadUrl.Split("/")[-1]
