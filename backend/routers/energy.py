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
    cursor.execute("""
        SELECT
            s.id,
            s.name,
            s.last_updated AS timestamp,
            (s.latest_data->>'a_act_power')::float    AS a_act,
            (s.latest_data->>'b_act_power')::float    AS b_act,
            (s.latest_data->>'c_act_power')::float    AS c_act,
            (s.latest_data->>'total_act_power')::float  AS total_act,
            (s.latest_data->>'total_aprt_power')::float AS total_aprt
        FROM sensors s
        JOIN sensor_types st ON s.type_id = st.id
        WHERE st.type = 'EnergyMeter'
          AND s.latest_data->>'a_act_power'       IS NOT NULL
          AND s.latest_data->>'b_act_power'       IS NOT NULL
          AND s.latest_data->>'c_act_power'       IS NOT NULL
          AND s.latest_data->>'total_act_power'   IS NOT NULL
          AND s.latest_data->>'total_aprt_power'  IS NOT NULL
        ORDER BY s.name, s.id, s.last_updated DESC
    """)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    if not rows:
        raise HTTPException(status_code=404, detail="No energy data found")

    results = {}
    for sensor_id, name, timestamp, a_act, b_act, c_act, total_act, total_aprt in rows:
        # Power factor
        if total_aprt and total_aprt > 0:
            pf = total_act / total_aprt
        else:
            pf = 0.0

        # Phase imbalance (% difference from average)
        phases = [a_act, b_act, c_act]
        avg = sum(phases) / 3.0 if sum(phases) > 0 else None
        imbalance = {}
        if avg and avg > 0:
            imbalance = {
                "A": round((a_act - avg) / avg * 100, 1),
                "B": round((b_act - avg) / avg * 100, 1),
                "C": round((c_act - avg) / avg * 100, 1),
            }

        results[sensor_id] = {
            "id": sensor_id,
            "name": name,
            "type": "EnergyMeter",
            "timestamp": timestamp.isoformat() if timestamp else None,
            "total_active_power_kw": round(total_act, 3),
            "power_factor": round(pf, 3),
            "phase_imbalance_percent": imbalance
        }

    return results

@router.get("/energy/notifications")
def get_energy_notifications():
    conn = connect_to_db()
    if not conn:
        raise HTTPException(500, "Database connection failed")
    cur = conn.cursor()
    cur.execute("""
        SELECT
          s.id,
          s.name,
          (s.latest_data->>'a_act_power')::float    AS a_act,
          (s.latest_data->>'b_act_power')::float    AS b_act,
          (s.latest_data->>'c_act_power')::float    AS c_act,
          (s.latest_data->>'total_act_power')::float AS total_act,
          (s.latest_data->>'total_aprt_power')::float AS total_aprt
        FROM sensors s
        JOIN sensor_types st ON s.type_id = st.id
        WHERE st.type = 'EnergyMeter'
          AND s.latest_data->>'total_act_power'    IS NOT NULL
          AND s.latest_data->>'total_aprt_power'   IS NOT NULL
          AND s.latest_data->>'a_act_power'        IS NOT NULL
          AND s.latest_data->>'b_act_power'        IS NOT NULL
          AND s.latest_data->>'c_act_power'        IS NOT NULL
        ORDER BY s.last_updated DESC
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()

    notes = []
    for sensor_id, name, a_act, b_act, c_act, total_act, total_aprt in rows:
        # 1) Low power factor
        if total_aprt > 0:
            pf = total_act / total_aprt
            if pf < 0.8:
                notes.append({
                    "id":    f"energy-{sensor_id}-pf",
                    "type":  "EnergyMeter",
                    "metric": "PowerFactor",
                    "severity": "Moderate",
                    "message": f"Sensor {name} low power factor: {pf:.2f}"
                })

        # 2) Phase imbalance
        phases = [a_act, b_act, c_act]
        avg = sum(phases) / 3.0
        for phase_label, val in zip(("A","B","C"), phases):
            if avg > 0:
                deviation = (val - avg) / avg
                if abs(deviation) > 0.25:
                    pct = deviation * 100
                    notes.append({
                        "id":     f"energy-{sensor_id}-imbalance-{phase_label}",
                        "type":   "EnergyMeter",
                        "metric": "PhaseImbalance",
                        "severity": "Moderate",
                        "message": (
                            f"Sensor {name} phase {phase_label} "
                            f"{'high' if pct>0 else 'low'} by {abs(pct):.0f}%"
                        )
                    })
    return notes