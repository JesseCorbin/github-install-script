# Ensure TLS 1.2 is used for secure downloads
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Set paths and URLs
$ChromeLog = "C:\Windows\Temp\ChromeInstall.log"
$MSIPath = "$env:TEMP\ChromeEnterprise.msi"
$DownloadUrl = "https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi"

Function Write-Log {
    param([string]$Message)
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $ChromeLog -Value "$TimeStamp $Message"
}

Write-Log "=== Starting Google Chrome Enterprise installation ==="

try {
    Write-Log "Downloading Chrome Enterprise MSI from $DownloadUrl"
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $MSIPath
    Write-Log "Download complete"
    # Install silently using msiexec
    Write-Log "Launching Chrome Enterprise MSI installer"
    $Process = Start-Process msiexec.exe -ArgumentList "/i", "`"$MSIPath`"", "/qn", "/norestart" -Wait -PassThru
    Write-Log "msiexec ExitCode = $($Process.ExitCode)"
    # Verify installation
    if (Test-Path "C:\Program Files\Google\Chrome\Application\chrome.exe") {
        Write-Log "Chrome installed successfully"
    } else {
        Write-Log "Chrome installation failed or not detected"
    }
} catch {
    Write-Log "ERROR: $($_.Exception.Message)"
}

Write-Log "=== Chrome installation script finished ==="
Remove-Item $MSIPath -Force
