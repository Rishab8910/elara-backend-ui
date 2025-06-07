
# === Launch ElaraV2 Backend UI Server ===
$backendPath = "C:\Users\admin\Music\ElaraV2\backend_ui"
$script = Join-Path $backendPath "backend_ui_server.py"

Write-Output "Launching ElaraV2 Control Panel..."
Start-Process "python" -ArgumentList "`"$script`""
