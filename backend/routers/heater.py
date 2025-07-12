# backend/routers/energy.py
from fastapi import APIRouter, HTTPException
from db_utils import connect_to_db

router = APIRouter()

@router.get("/heater")
def get_heater_data():
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=500, detail="Database connection failed")

    cursor = conn.cursor()

    # Get latest row per heater sensor
    cursor.execute("""
        SELECT
            sensor.id, 
            sensor.name,
            sensor.last_updated AS timestamp,
            sensor.latest_data->>'ValvePosition' AS valve_position, 
            sensor.latest_data->>'TargetTemperature' AS target_temperature,
            sensor.latest_data->>'Temperature' AS temperature,
            sensor.latest_data->>'Battery' AS battery
        FROM sensors as sensor, sensor_types as stype
        WHERE sensor.type_id = stype.id
        AND stype.type = 'Heater'
        ORDER BY name, id, timestamp DESC
    """)

    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    if not rows:
        raise HTTPException(status_code=404, detail="No heater data found")

    results = {}
    for row in rows:
        sensor_id, name, timestamp, valve_position, target_temperature, temperature, battery = row

        results[sensor_id] = {
            "Timestamp": timestamp.isoformat() if timestamp else None,
            "Name": name,
            "Type": "Heater",
            "Measurements": [
                {
                    "Value": {
                        "ValvePosition": int(valve_position) if valve_position else None,
                        "TargetTemperature": float(target_temperature) if target_temperature else None,
                        "Temperature": float(temperature) if temperature else None,
                        "Battery": int(battery) if battery else None
                    }
                }
            ]
        }

    return results