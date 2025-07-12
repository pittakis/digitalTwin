# Digital Twin Web Application

A full-stack web application that provides a digital twin platform for real-time sensor monitoring, energy modeling, and 3D visualization.

## Features

- Real-time sensor data ingestion and visualization  
- Energy consumption modeling and analysis  
- 3D model rendering (`.glb` support)  
- User authentication and role-based access  

## Prerequisites

- **Python** 3.10+  
- **Node.js** 18+ and **npm**  
- **Git** and **Git LFS** (for large model assets)  
- A relational database (e.g., PostgreSQL, MySQL, or SQLite)

## Installation

1. **Clone the repository**
   ```bash
   git clone git@github.com:pittakis/digitalTwin.git
   cd digitalTwinWebApp
   ```
2. **Setup Python backend**
    ```bash
    python3 -m venv dtvenv
    source dtvenv/bin/activate
    pip install -r requirements.txt
    ```
3. **Setup Frontend**
    ```bash
    cd frontend
    npm install
    cd ..
    ```

## Running the application
1. **Start the backend**
2. **Start the frontend**
3. **Open your browser at http://localhost:7779**

## License
This project is licensed under the MIT License. See LICENSE for details.
