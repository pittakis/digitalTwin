# Digital Twin Web Application

A full‑stack web application that provides a digital twin platform for real‑time sensor monitoring, energy modeling, and 3D visualization.

## Features

- Real-time sensor data ingestion and visualization  
- Energy consumption modeling and analysis  
- 3D model rendering (`.glb` support)  
- User authentication and role-based access  

## Prerequisites

- **Docker Desktop** (Windows/macOS) or **Docker Engine** (Linux)

---

## Get the Code

### Option A — Clone with Git (recommended)
```bash
git clone git@github.com:pittakis/digitalTwin.git
cd digitalTwin
```

### Option B — Download ZIP
1. Click Code ▸ Download ZIP.
2. Extract the archive, then open a terminal in the extracted digitalTwin/ folder.

## Initialize Project Files (env + public assets)
There is a initialize/ folder with setup scripts and assets.
Place the initialize/ folder inside the project root directory.
Running the script will:
- Copy initialize/.env_backend → backend/.env
- Copy initialize/.env_frontend → frontend/.env
- Copy all other assets in initialize/ (e.g., *.glb, images, textures/, etc.) into frontend/public/

### Windows (PowerShell)
```bash
cd .\initialize
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setUpWindows.ps1
```
### macOS / Linux (bash)
```bash
cd ./initialize
chmod +x ./setUpUbuntuMacOs.sh
./setUpUbuntuMacOs.sh
```

## Run the application
1. **Start the Docker**
   ```bash
   docker compose up --build
   ``` 
2. **Open your browser at http://localhost:7779**

## License
This project is licensed under the MIT License. See LICENSE for details.


