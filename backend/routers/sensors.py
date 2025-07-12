from fastapi import APIRouter, HTTPException
from db_utils import connect_to_db

router = APIRouter()

def fetch_data_as_dict(cursor, query):
    cursor.execute(query)
    columns = [col[0] for col in cursor.description]
    return [dict(zip(columns, row)) for row in cursor.fetchall()]

@router.get("/sensors")
def get_all_sensor_data():
    sensors_data = {}
    conn = connect_to_db()
    if conn:
        cursor = conn.cursor()
        sensors_data["EnergyMeter"] = fetch_data_as_dict(cursor, "SELECT * FROM sensors WHERE type_id = (SELECT id FROM sensor_types WHERE type = 'EnergyMeter')")
        sensors_data["AirQuality"] = fetch_data_as_dict(cursor, "SELECT * FROM sensors WHERE type_id = (SELECT id FROM sensor_types WHERE type = 'AirQuality')")
        sensors_data["Heater"] = fetch_data_as_dict(cursor, "SELECT * FROM sensors WHERE type_id = (SELECT id FROM sensor_types WHERE type = 'Heater')")
        cursor.close()
        conn.close()
        if not any(sensors_data.values()):
            raise HTTPException(status_code=404, detail="No sensor data found")
        return sensors_data

@router.get("/getSensorNames")
def get_sensor_names():
    sensor_names = []
    conn = connect_to_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM sensors ORDER BY name")
        sensor_names = [row[0] for row in cursor.fetchall()]
        cursor.close()
        conn.close()
    if not sensor_names:
        raise HTTPException(status_code=404, detail="No sensors found")
    return sensor_names

@router.get("/getSensorData/{sensor_name}")
def get_sensor_data(sensor_name: str):
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=500, detail="Database connection failed")
    
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM sensors WHERE name = %s", (sensor_name,))
    sensor_data = cursor.fetchone()
    
    cursor.close()
    conn.close()
    
    if not sensor_data:
        raise HTTPException(status_code=404, detail=f"Sensor '{sensor_name}' not found")
    
    columns = [col[0] for col in cursor.description]
    return dict(zip(columns, sensor_data))