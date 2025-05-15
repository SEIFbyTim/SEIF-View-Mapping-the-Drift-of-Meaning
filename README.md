
# SEIF-View Demo App

## Overview
This demo showcases symbolic hallucination and drift detection for narrative or AI outputs using SEIF-View.

## Structure
- `backend/`: A Python Flask API to simulate symbolic scoring.
- `ios_client/`: SwiftUI code snippet for building an iOS demo interface.

## Running the Backend
```bash
cd backend
pip install flask flask-cors
python seif_view_api.py
```

## Notes
- For iOS physical device testing, replace `127.0.0.1` with your machine's LAN IP.
