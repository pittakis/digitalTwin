import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";

export default function Dashboard() {
  const navigate = useNavigate();
  const [forecast, setForecast] = useState(null);
  const [error, setError] = useState(null);
  const [notifications, setNotifications] = useState([]);
  const [params, setParams] = useState(null);
  const [sensorType, setSensorType] = useState("All");
  const [criteria, setCriteria] = useState("");

  // Auth guard
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (!token) navigate("/login");
  }, [navigate]);

  // Fetch weather once and compute PMV params + forecast
  useEffect(() => {
    const apiKey = import.meta.env.VITE_OWM_KEY;
    if (!apiKey) {
      setError("API key not found. Set VITE_OWM_KEY in .env");
      return;
    }
    const lat = 52.2297;
    const lon = 21.0122;

    axios
      .get("https://api.openweathermap.org/data/2.5/weather", { params: { lat, lon, units: "metric", appid: apiKey } })
      .then(res => {
        const w = res.data;
        const met = 1.1;
        const clo = w.main.temp <= 10 ? 1.0 : w.main.temp <= 20 ? 0.7 : 0.5;
        const v_air = Math.min(Math.max(w.wind.speed || 0.1, 0), 0.3);
        setParams({ met, clo, v_air });
        return axios.get("https://api.openweathermap.org/data/2.5/forecast", { params: { lat, lon, units: "metric", appid: apiKey } });
      })
      .then(res => setForecast(res.data))
      .catch(err => setError(err.message));
  }, []);

  // Fetch PMV notifications
  useEffect(() => {
    if (!params) return;
    const fetchPmv = () => {
      axios
        .get("http://127.0.0.1:7781/api/pmv", { params })
        .then(res => {
          const pmvNotes = res.data
            .filter(s => s.status !== "Comfortable")
            .map(s => ({ id: `pmv-${s.id}`, message: `Sensor ${s.name} PMV is ${s.status}`, severity: s.status, type: "AirQuality" }));
          setNotifications(prev => [...prev.filter(n => n.type !== "AirQuality"), ...pmvNotes]);
        })
        .catch(() => setError("Failed to fetch PMV data"));
    };
    fetchPmv();
    const interval = setInterval(fetchPmv, 600000);
    return () => clearInterval(interval);
  }, [params]);

  // Fetch Heater notifications
  useEffect(() => {
    const fetchHeater = () => {
      axios
        .get("http://127.0.0.1:7781/api/getSensorNotifications")
        .then(res => {
          const heaterNotes = res.data.flatMap(row => {
            const [id, name,, , targetTemp, temp, battery] = row;
            const notes = [];
            if (battery < 20) notes.push({ id: `heater-${id}-battery`, message: `Sensor ${name} battery low: ${battery}%`, severity: "Moderate", type: "Heater", metric: "Battery" });
            const diff = temp - targetTemp;
            if (Math.abs(diff) > 2) notes.push({ id: `heater-${id}-temp`, message: `Sensor ${name} temp deviates by ${Math.abs(diff).toFixed(1)}°C`, severity: "Uncomfortable", type: "Heater", metric: "Temperature" });
            return notes;
          });
          setNotifications(prev => [...prev.filter(n => n.type !== "Heater"), ...heaterNotes]);
        })
        .catch(() => setError("Failed to fetch Heater notifications"));
    };
    fetchHeater();
    const interval = setInterval(fetchHeater, 600000);
    return () => clearInterval(interval);
  }, []);

  // Fetch EnergyMeter notifications
  useEffect(() => {
    const fetchEnergy = () => {
      axios
        .get("http://127.0.0.1:7781/api/energy/notifications")
        .then(res => {
          const energyNotes = res.data.map(n => ({ id: n.id, message: n.message, severity: n.severity, type: "EnergyMeter", metric: n.metric }));
          setNotifications(prev => [...prev.filter(n => n.type !== "EnergyMeter"), ...energyNotes]);
        })
        .catch(() => setError("Failed to fetch EnergyMeter notifications"));
    };
    fetchEnergy();
    const interval = setInterval(fetchEnergy, 600000);
    return () => clearInterval(interval);
  }, []);

  const handleRemove = index => setNotifications(notifications.filter((_, i) => i !== index));

  const nextEntry = forecast?.list?.[0];
  const cityName = forecast?.city?.name;

  // Filter notifications
  let visible = notifications;
  if (sensorType !== "All") {
    visible = visible.filter(n => n.type === sensorType);
    if (criteria) {
      visible = visible.filter(n =>
        sensorType === "Heater"
          ? n.metric === criteria
          : sensorType === "EnergyMeter"
          ? n.metric === criteria
          : n.severity === criteria
      );
    }
  }

  return (
    <div style={styles.layout}>
      <div style={styles.sidebar}>
        <h1 style={styles.logo}>🖥️ Digital Twin</h1>
        <div style={styles.menu}>
          <button onClick={() => navigate("/sensors")} style={styles.button}>📊 Sensor Data</button>
          <button onClick={() => navigate("/energy-overview")} style={styles.button}>⚡ Energy Overview</button>
          <button onClick={() => navigate("/heater-overview")} style={styles.button}>🔥 Heater Overview</button>
          <button onClick={() => navigate("/pmv")} style={styles.button}>🌡️ PMV Calculator</button>
          <button onClick={() => navigate("/building-3d")} style={styles.button}>🏗️ 3D Building View</button>
        </div>
      </div>
      <div style={styles.content}>
        {error && <p style={styles.error}>Error: {error}</p>}
        {!forecast && !error && <p style={styles.loading}>Loading…</p>}
        {nextEntry && (
          <div style={styles.weatherCard}>
            <p style={styles.city}>{cityName}</p>
            <p style={styles.forecastTime}>{new Date(nextEntry.dt * 1000).toLocaleString()}</p>
            <img src={`https://openweathermap.org/img/wn/${nextEntry.weather[0].icon}@2x.png`} alt={nextEntry.weather[0].description} style={styles.icon} />
            <p style={styles.temp}>{nextEntry.main.temp.toFixed(1)}°C</p>
            <p style={styles.desc}>{nextEntry.weather[0].main}</p>
            <p style={styles.details}>Humidity: {nextEntry.main.humidity}% · Wind: {nextEntry.wind.speed} m/s</p>
          </div>
        )}
        {/* Notifications header with filters */}
        <div style={styles.notificationsContainer}>
          <div style={styles.notificationsHeader}>
            <span>Notifications ({visible.length})</span>
            <div style={styles.filterControls}>
              <select value={sensorType} onChange={e => { setSensorType(e.target.value); setCriteria(""); }} style={styles.dropdown}>
                <option value="All">All</option>
                <option value="Heater">Heater</option>
                <option value="AirQuality">AirQuality</option>
                <option value="EnergyMeter">EnergyMeter</option>
              </select>
              {sensorType !== "All" && (
                <select value={criteria} onChange={e => setCriteria(e.target.value)} style={styles.dropdown}>
                  <option value="">--Filter--</option>
                  {sensorType === "Heater" && ["Battery", "Temperature"].map(o => <option key={o} value={o}>{o}</option>)}
                  {sensorType === "AirQuality" && ["Moderate", "Uncomfortable"].map(o => <option key={o} value={o}>{o}</option>)}
                  {sensorType === "EnergyMeter" && ["PowerFactor", "PhaseImbalance"].map(o => <option key={o} value={o}>{o}</option>)}
                </select>
              )}
              {visible.length > 0 && <button onClick={() => setNotifications([])} style={styles.clearAllBtn}>Clear All</button>}
            </div>
          </div>
          <div style={styles.notificationsListWrapper}>
            {visible.length === 0 ? (
              <p style={styles.noNotifications}>No notifications</p>
            ) : (
              <ul style={styles.notificationsList}>
                {visible.map((note, i) => (
                  <li key={note.id} style={{ ...styles.notificationItem, backgroundColor: note.severity === "Uncomfortable" ? "#f8d7da" : "#fff3cd", color: note.severity === "Uncomfortable" ? "#a71d2a" : "#856404" }}>
                    <span>{note.message}</span>
                    <button onClick={() => handleRemove(i)} style={styles.removeBtn}>×</button>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

const styles = {
  layout: { display: "flex", minHeight: "100vh", fontFamily: "Segoe UI, sans-serif", background: "#ecf0f1" },
  sidebar: { width: "380px", background: "#34495e", color: "white", padding: "2rem 1rem", boxShadow: "2px 0 8px rgba(0,0,0,0.1)" },
  logo: { margin: 0, marginBottom: "2rem", fontSize: "1.5rem", textAlign: "center" },
  menu: { display: "flex", flexDirection: "column", gap: "1rem" },
  button: { padding: "0.75rem", fontSize: "1rem", borderRadius: "8px", border: "none", background: "#2980b9", color: "white", cursor: "pointer", transition: "background 0.2s", textAlign: "left" },
  content: { flex: 1, padding: "1rem 2rem", position: "relative" },
  weatherCard: { background: "white", width: "240px", height: "280px", padding: "1rem", borderRadius: "12px", boxShadow: "0 4px 16px rgba(0,0,0,0.1)", textAlign: "center", marginBottom: "1rem", display: "flex", flexDirection: "column", justifyContent: "space-between" },
  city: { margin: 0, fontSize: "1rem", color: "#34495e", fontWeight: "bold" },
  forecastTime: { fontSize: "0.75rem", color: "#555" },
  icon: { width: "70px", height: "70px", margin: "0 auto" },
  temp: { fontSize: "1.6rem", margin: "0.25rem 0" },
  desc: { textTransform: "capitalize", fontSize: "0.9rem", color: "#555" },
  details: { fontSize: "0.75rem", color: "#777" },
  notificationsContainer: { position: "fixed", bottom: 0, left: "380px", right: 0, height: "400px", background: "#f9f9f9", padding: "1rem", borderTop: "1px solid #ddd", display: "flex", flexDirection: "column", zIndex: 100 },
  notificationsHeader: { flex: "0 0 auto", display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "0.5rem", fontWeight: "bold" },
  filterControls: { display: "flex", gap: "0.5rem", alignItems: "center" },
  dropdown: { padding: "0.5rem", fontSize: "0.9rem", borderRadius: "6px", border: "1px solid #ccc" },
  clearAllBtn: { background: "none", border: "none", color: "#007BFF", cursor: "pointer", fontSize: "0.9rem" },
  notificationsListWrapper: { flex: "1 1 auto", overflowY: "auto" },
  noNotifications: { color: "#555", fontStyle: "italic" },
  notificationsList: { listStyle: "none", padding: 0, margin: 0 },
  notificationItem: { display: "flex", justifyContent: "space-between", alignItems: "center", padding: "0.5rem", borderRadius: "6px", marginBottom: "0.5rem" },
  removeBtn: { background: "none", border: "none", color: "#856404", fontWeight: "bold", cursor: "pointer", fontSize: "1rem" }
};
