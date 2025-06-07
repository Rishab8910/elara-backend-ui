
# === ElaraV2 PowerShell Auto-Deploy Script (Improved) ===
$source = "C:\Users\admin\Downloads\FOR POWERSHELL"
$destination = "C:\Users\admin\Music\ElaraV2"
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backup = Join-Path $destination "backup_$timestamp"

Write-Output "Creating backup directory: $backup"
New-Item -ItemType Directory -Force -Path $backup | Out-Null

Write-Output "Backing up ElaraV2 (excluding existing backups)..."
Get-ChildItem -Path $destination -Recurse -Force |
    Where-Object { $_.FullName -notmatch "\\backup_\d{8}_\d{6}" } |
    ForEach-Object {
        $target = $_.FullName.Replace($destination, $backup)
        if ($_.PSIsContainer) {
            New-Item -ItemType Directory -Path $target -Force | Out-Null
        } else {
            Copy-Item $_.FullName -Destination $target -Force
        }
    }

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
