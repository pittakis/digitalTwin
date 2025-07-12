# backend/routers/energy.py
from fastapi import APIRouter, HTTPException
from db_utils import connect_to_db

router = APIRouter()

@router.get("/energy")
def get_all_energy_data():
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=500, detail="Database connection failed")

    cursor = conn.cursor()

    # Get the latest row per sensor using DISTINCT ON
    cursor.execute("""
        SELECT
            sensor.id,
            sensor.name,
            sensor.last_updated AS timestamp,
            sensor.latest_data->>'total_act_power' AS total_act_power,
            sensor.latest_data->>'total_aprt_power' AS total_aprt_power
        FROM sensors as sensor, sensor_types as stype
        WHERE sensor.type_id = stype.id
        AND stype.type = 'EnergyMeter'
        ORDER BY name, id, timestamp DESC
    """)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    if not rows:
        raise HTTPException(status_code=404, detail="No energy data found")

    results = {}
    i =0
    for row in rows:
        sensor_id, name, timestamp, total_act_power, total_aprt_power = row
        # Calculate power factor
        if total_aprt_power and float(total_aprt_power) > 0:
            power_factor = float(total_act_power) / float(total_aprt_power)
        else:
            power_factor = 0

        results[sensor_id] = {
            "name": name,
            "id": sensor_id,
            "type": "EnergyMeter",
            "timestamp": timestamp.isoformat() if timestamp else None,
            "total_active_power_kw": round(float(total_act_power), 3) if total_act_power else None,
            "power_factor": round(power_factor, 3)
        }

    return results
