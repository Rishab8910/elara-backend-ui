
# === ElaraV2 PowerShell Auto-Deploy Script (Final + Logging) ===
$source = "C:\Users\admin\Downloads\FOR POWERSHELL"
$destination = "C:\Users\admin\Music\ElaraV2"
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backup = Join-Path $destination "backup_$timestamp"
$logFile = Join-Path $destination "deployment.log"

function Log {
    param ([string]$message)
    $entry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $message"
    Write-Output $entry
    Add-Content -Path $logFile -Value $entry
}

Log "=== ElaraV2 Deployment Started ==="
Log "Creating backup at $backup"
New-Item -ItemType Directory -Force -Path $backup | Out-Null

Log "Backing up files (excluding existing backups)..."
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

Log "Deploying updated files from $source to $destination..."
Copy-Item "$source\*.py" -Destination $destination -Force
Copy-Item "$source\*.json" -Destination $destination -Force
Copy-Item "$source\*.yaml" -Destination $destination -Force
Copy-Item "$source\config\*" -Destination (Join-Path $destination "config") -Recurse -Force -ErrorAction SilentlyContinue

$backupRes = Join-Path $destination "BREW_BIONIC_BACKUP"
if (!(Test-Path $backupRes)) {
    New-Item -ItemType Directory -Force -Path $backupRes | Out-Null
}
Copy-Item "$source\BREW_BIONIC_BACKUP\*" -Destination $backupRes -Recurse -Force -ErrorAction SilentlyContinue

Log "Deployment complete. All updated files are now active."
