
# ElaraV2 Backend UI

This is the backend control panel for the ElaraV2 AI-Powered Robotic Bartender system.

## 🚀 How to Run

1. Open PowerShell
2. Run the launcher:

```powershell
powershell -ExecutionPolicy Bypass -File RUN_UI_SERVER.ps1
```

3. Open your browser at: `http://localhost:5050`

## 🧩 Modules

- Flask API (`backend_ui_server.py`)
- Admin Dashboard (`index.html`)
- Configurable via `elara_config_backend.json`

## 🔒 Security

- Currently auto-logs in as admin
- Future toggle available in `elara_config_backend.json`

## 🧹 Git Hygiene

- Sensitive files, logs, and PowerShell scripts are ignored via `.gitignore`
