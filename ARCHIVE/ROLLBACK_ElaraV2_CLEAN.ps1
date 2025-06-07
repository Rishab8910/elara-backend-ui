
# === ElaraV2 Auto-Rollback Script (Cleaned) ===
$destination = "C:\Users\admin\Music\ElaraV2"
$latestBackup = Get-ChildItem -Directory $destination | Where-Object { $_.Name -like "backup_*" } |
    Sort-Object Name -Descending | Select-Object -First 1

if ($null -eq $latestBackup) {
    Write-Output "No backup folder found. Rollback aborted."
    exit 1
}

Write-Output "Rolling back using: $($latestBackup.FullName)"
Copy-Item "$($latestBackup.FullName)\*" -Destination $destination -Recurse -Force

Write-Output "Rollback complete. ElaraV2 restored to backup: $($latestBackup.Name)"
