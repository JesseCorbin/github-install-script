$owner = "OWNER"
$repo = "REPO"
$filter = "*.exe" # Use part of the filename, e.g., "installer.exe", or "*.exe" for any exe.
$apiUrl = "https://api.github.com/repos/$owner/$repo/releases/latest"

# Get release info
$content = Invoke-RestMethod -Uri $apiUrl

# Find the asset URL matching your filename
$downloadUrl = $content.assets | Where-Object { $_.name -like $filter } | Select-Object -ExpandProperty browser_download_url

# Download the file to current directory
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadUrl.Split("/")[-1]
