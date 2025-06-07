
from flask import Flask, jsonify, render_template
import json
import os

app = Flask(__name__, template_folder="templates", static_folder="static")

# Load config
config_path = os.path.join(os.path.dirname(__file__), "elara_config_backend.json")
if os.path.exists(config_path):
    with open(config_path, "r") as f:
        config = json.load(f)
else:
    config = {"network_mode": "local", "admin_auto_login": True}

@app.route("/")
def dashboard():
    if config.get("admin_auto_login"):
        return render_template("index.html", role="admin")
    return "Login required", 401

@app.route("/api/status")
def system_status():
    return jsonify({
        "agent": "running",
        "robot": "online",
        "coffee_machine": "ok",
        "fog_machine": "ok"
    })

@app.route("/api/inventory")
def inventory_data():
    return jsonify({
        "milk_ml": 2800,
        "powder_g": 750,
        "cups_remaining": 21
    })

if __name__ == "__main__":
    port = 5050
    app.run(host="127.0.0.1", port=port, debug=True)
