
# === Unzip and Deploy ElaraV2 Backend UI ===

$zipPath = "C:\Users\admin\Downloads\BACKEND_UI_MODULE.zip"
$extractTo = "C:\Users\admin\Downloads\FOR POWERSHELL"
$destination = "C:\Users\admin\Music\ElaraV2\backend_ui"
$logFile = Join-Path $destination "backend_ui_deploy.log"

# Extract zip
Expand-Archive -LiteralPath $zipPath -DestinationPath $extractTo -Force

# Create destination if needed
if (!(Test-Path $destination)) {
    New-Item -ItemType Directory -Path $destination | Out-Null
}

# Copy all files from FOR POWERSHELL into backend_ui folder
Get-ChildItem -Path $extractTo -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Substring($extractTo.Length)
    $target = Join-Path $destination $relativePath.TrimStart('\')
    if ($_.PSIsContainer) {
        if (!(Test-Path $target)) {
            New-Item -ItemType Directory -Path $target -Force | Out-Null
        }
    } else {
        Copy-Item $_.FullName -Destination $target -Force
        $logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Copied: $($_.FullName) to $target"
        Add-Content -Path $logFile -Value $logEntry
    }
}

Write-Output "Backend UI deployed successfully to $destination"
