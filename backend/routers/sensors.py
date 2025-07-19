from fastapi import APIRouter, HTTPException
from db_utils import connect_to_db
from datetime import datetime, timedelta

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

@router.get("/getSensorNotifications")
def get_sensor_notifications():
    notifications = []
    conn = connect_to_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT DISTINCT ON (s.id)
                s.id,
                s.name,
                s.last_updated   AS timestamp,
                (s.latest_data->>'ValvePosition')::INT        AS valve_position,
                (s.latest_data->>'TargetTemperature')::FLOAT  AS target_temperature,
                (s.latest_data->>'Temperature')::FLOAT        AS temperature,
                (s.latest_data->>'Battery')::INT              AS battery
            FROM sensors AS s
            JOIN sensor_types AS st 
            ON s.type_id = st.id
            WHERE st.type = 'Heater'
            AND s.latest_data->>'ValvePosition'    IS NOT NULL
            AND s.latest_data->>'TargetTemperature' IS NOT NULL
            AND s.latest_data->>'Temperature'       IS NOT NULL
            AND s.latest_data->>'Battery'           IS NOT NULL
            ORDER BY 
                s.id,
                s.last_updated DESC;
        """)
        notifications = cursor.fetchall()
        cursor.close()
        conn.close()
        if not notifications:
            return []
        return notifications
    
@router.get("/sensor/status")
def get_sensor_status():
    """Return all sensors in building 1 with a health status and messages."""
    conn = connect_to_db()
    if not conn:
        raise HTTPException(500, "Database connection failed")

    cursor = conn.cursor()
    cursor.execute("""
        SELECT
            s.id,
            s.name,
            s.location,
            s.last_updated,
            s.latest_data,
            st.type
        FROM sensors AS s
        JOIN sensor_types AS st
          ON s.type_id = st.id
        WHERE s.building_id = 1
    """)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    if not rows:
        return []

    sensors = []
    now = datetime.utcnow()
    for sensor_id, name, location, last_updated, latest_data, sensor_type in rows:
        # latest_data comes back as a Python dict
        ld = latest_data or {}

        # 1) default status
        status = "green"
        messages = []

        # 2) check “last seen”
        if not last_updated or (now - last_updated) > timedelta(hours=2):
            status = "red"
            messages.append("No data received in >2 h")

        # 3) heater‐specific checks
        if sensor_type == "Heater":
            # battery
            batt = ld.get("Battery")
            if batt is not None and batt < 10:
                if status != "red":
                    status = "yellow"
                messages.append(f"Battery low: {batt}%")

            # temperature deviation
            tgt = ld.get("TargetTemperature")
            tmp = ld.get("Temperature")
            if tgt is not None and tmp is not None:
                diff = abs(tmp - tgt)
                if diff > 2:
                    if status != "red":
                        status = "yellow"
                    messages.append(f"Temp deviates by {diff:.1f}°C")

        # 4) (you can add AirQuality or EnergyMeter rules here...)

        sensors.append({
            "id": sensor_id,
            "name": name,
            "location": location,
            "type": sensor_type,
            "last_seen": last_updated.isoformat() if last_updated else None,
            "latest_data": ld,
            "status": status,
            "messages": messages
        })

    return sensors
