# backend/routers/pmv.py
from fastapi import APIRouter, HTTPException
from pythermalcomfort.models import pmv_ppd_iso
from db_utils import connect_to_db

router = APIRouter()
@router.get("/pmv")
def get_pmv():
    conn = connect_to_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT
                sensor.id,
                sensor.name,
                sensor.last_updated AS timestamp,
                sensor.latest_data->>'temperature' AS temperature,
                sensor.latest_data->>'humidity' AS humidity
            FROM sensors as sensor, sensor_types as stype
            WHERE sensor.type_id = stype.id
            AND stype.type = 'AirQuality'
            ORDER BY name, id, timestamp DESC
        """)

        pmv_data = cursor.fetchall()
        cursor.close()
        conn.close()

        if not pmv_data:
            raise HTTPException(status_code=404, detail="No PMV data found")
        # calculate PMV for each sensor
        pmv_results = {}
        for row in pmv_data:
            sensor_id, name, timestamp, temperature, humidity = row
            if not temperature or not humidity:
                continue
            try:
                temperature = float(temperature)
                humidity = float(humidity)
            except ValueError:
                continue 
            
            # PMV calculation parameters
            met = 1.1
            clo = 0.5
            v_air = 0.1
            result = pmv_ppd_iso(
                tdb=temperature,
                tr=temperature,
                vr=v_air,
                rh=humidity,
                met=met,
                clo=clo,
                model="7730-2005"
            )
            
            pmv_results[sensor_id] = {
                "name": name,
                "id": sensor_id,
                "type": "AirQuality",
                "timestamp": timestamp.isoformat() if timestamp else None,
                "temperature": temperature if temperature else None,
                "humidity": humidity if humidity else None,
                "pmv": round(result.pmv, 2),
                "ppd": round(result.ppd, 1),
                "status": "Comfortable" if abs(result.pmv) < 0.5 else "Critical" if abs(result.pmv) < 0.7 else "Uncomfortable"
            }
        return pmv_results
    