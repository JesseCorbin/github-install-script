# Install VS Code with context menu, PATH, and file association options
winget install --id Microsoft.VisualStudioCode -e `
--accept-package-agreements --accept-source-agreements `
--override '/VERYSILENT /MERGETASKS="addcontextmenufiles,addcontextmenufolders,addtopath,associatewithfiles"'
