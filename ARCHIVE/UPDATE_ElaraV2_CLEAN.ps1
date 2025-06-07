
# === ElaraV2 PowerShell Auto-Deploy Script ===
$source = "C:\Users\admin\Downloads\FOR POWERSHELL"
$destination = "C:\Users\admin\Music\ElaraV2"
$backup = Join-Path $destination "backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

Write-Output "Backing up existing ElaraV2 to $backup"
New-Item -ItemType Directory -Force -Path $backup | Out-Null
Copy-Item "$destination\*" -Destination $backup -Recurse -Force

Write-Output "Deploying new files from $source to $destination..."
Copy-Item "$source\*.py" -Destination $destination -Force
Copy-Item "$source\*.json" -Destination $destination -Force
Copy-Item "$source\*.yaml" -Destination $destination -Force
Copy-Item "$source\config\*" -Destination (Join-Path $destination "config") -Recurse -Force -ErrorAction SilentlyContinue

$backupRes = Join-Path $destination "BREW_BIONIC_BACKUP"
if (!(Test-Path $backupRes)) {
    New-Item -ItemType Directory -Force -Path $backupRes | Out-Null
}
Copy-Item "$source\BREW_BIONIC_BACKUP\*" -Destination $backupRes -Recurse -Force -ErrorAction SilentlyContinue

Write-Output "Deployment complete."
Write-Output "All updated files are now active in ElaraV2."
