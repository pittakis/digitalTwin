import json
from datetime import datetime
from collections import defaultdict
from pythermalcomfort.models import pmv_ppd_iso
import paho.mqtt.client as mqtt
import threading
from db_utils import connect_to_db
import os

USERNAME = os.getenv("MQTT_USERNAME")
PASSWORD = os.getenv("MQTT_PASSWORD")
BROKER = os.getenv("MQTT_BROKER")
PORT = int(os.getenv("MQTT_PORT"))

# PMV parameters]
met = 1.1
clo = 0.5
v_air = 0.1
latest_pmv_data = {}

# === Device Categories by Prefix ===
AIR_QUALITY_IDS = set()
ENERGY_METER_IDS = set()
HEATER_IDS = set()

def get_sensor_ids():
    conn = connect_to_db()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT sensor.id, stypes.type FROM sensors as sensor, sensor_types as stypes WHERE sensor.type_id = stypes.id")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        for sensor_id, sensor_type in rows:
            if sensor_type == "AirQuality":
                AIR_QUALITY_IDS.add(sensor_id)
            elif sensor_type == "EnergyMeter":
                ENERGY_METER_IDS.add(sensor_id)
            elif sensor_type == "Heater":
                HEATER_IDS.add(sensor_id)

def add_sensor_data_to_db(equipment_id, timestamp, values):
    conn = connect_to_db()
    cursor = conn.cursor()
    try:
        cursor.execute("""
            UPDATE sensors
            SET latest_data = %s,
                last_updated = %s
            WHERE id = %s
        """, (json.dumps(values), timestamp, equipment_id))

        # Insert into sensor_data history table
        cursor.execute("""
            INSERT INTO sensor_data (sensor_id, data, timestamp)
            VALUES (%s, %s, %s)
        """, (equipment_id, json.dumps(values), timestamp))

        # Keep only the most recent 20 entries per sensor
        cursor.execute("""
            DELETE FROM sensor_data
            WHERE id IN (
                SELECT id FROM sensor_data
                WHERE sensor_id = %s
                ORDER BY timestamp ASC
                OFFSET 20
            )
        """, (equipment_id,))

        conn.commit()
        # print("Sensor JSON data inserted successfully.")
    except Exception as e:
        conn.rollback()
        print("Error inserting sensor data:", e)
    finally:
        cursor.close()
        conn.close()

def categorize_device(equipment_id):
    # print(f"Categorizing device with ID: {equipment_id}")
    if equipment_id in AIR_QUALITY_IDS:
        return "AirQuality"
    elif equipment_id in ENERGY_METER_IDS:
        return "EnergyMeter"
    elif equipment_id in HEATER_IDS:
        return "Heater"
    return None

def on_connect(client, userdata, flags, rc):
    print(f"MQTT Connected in sensors_realtime (rc={rc})")
    client.subscribe("#")

def on_message(client, userdata, msg):
    try:
        payload = msg.payload.decode("utf-8").strip()
        if not payload.startswith("{"):
            return
        data = json.loads(payload)

        timestamp = data.get("Timestamp")
        measurements = data.get("Measurements", [])
        if not timestamp or not measurements:
            return

        values = measurements[0].get("Value")
        if not isinstance(values, dict):
            return

        equipment_id = msg.topic.split("/")[-1]
        category = categorize_device(equipment_id)

        if category:
            add_sensor_data_to_db(equipment_id, timestamp, values)

    except Exception as e:
        print(f"MQTT error: {e}")

def mqtt_loop():
    try:
        client = mqtt.Client()
        client.username_pw_set(USERNAME, PASSWORD)
        client.on_connect = on_connect
        client.on_message = on_message
        client.connect(BROKER, PORT, 60)
        client.loop_forever()
    except Exception as e:
        print(f"MQTT connection error: {e}")

def run_sensor_listener():
    get_sensor_ids()
    mqtt_thread = threading.Thread(target=mqtt_loop, daemon=True)
    mqtt_thread.start()