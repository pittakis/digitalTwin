# backend/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routers.auth import router as auth_router
from routers.pmv import router as pmv_router
from routers.sensors import router as sensor_router
from routers.energy import router as energy_router
from routers.heater import router as heater_router
from routers.model3d import router as model3d_router
from routers.upload import router as upload_router

#from pmv_realtime import run_mqtt_listener as run_pmv_listener, latest_pmv_data
from sensors_realtime import run_sensor_listener

app = FastAPI()

# CORS for frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routes
app.include_router(auth_router, prefix="/api")
app.include_router(pmv_router, prefix="/api")
app.include_router(sensor_router, prefix="/api")
app.include_router(energy_router, prefix="/api")
app.include_router(heater_router, prefix="/api")
app.include_router(model3d_router, prefix="/api")
app.include_router(upload_router, prefix="/api")

# Start MQTT listener
#run_pmv_listener()
run_sensor_listener()
