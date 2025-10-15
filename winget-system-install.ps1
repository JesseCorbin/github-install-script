# Run as Administrator

# Download required dependencies
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.3 -OutFile xaml.zip
Expand-Archive -Path xaml.zip -DestinationPath xaml
Add-AppxProvisionedPackage -Online -PackagePath "xaml\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx" -SkipLicense

# Get the latest WinGet bundle
$uri = "https://aka.ms/getwinget"
Invoke-WebRequest -Uri $uri -OutFile winget.msixbundle

# System-wide (all users) installation
Add-AppxProvisionedPackage -Online -PackagePath winget.msixbundle -SkipLicense

# Cleanup
Remove-Item Microsoft.VCLibs.x64.14.00.Desktop.appx, xaml.zip, winget.msixbundle -Force
Remove-Item xaml -Recurse -Force
