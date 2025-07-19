import { useEffect, useState, useRef } from "react";
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
  const notificationsRef = useRef();
  const initialHeight = window.innerHeight * 0.3;
  const [paneHeight, setPaneHeight] = useState(initialHeight);
  // Auth guard
  useEffect(() => {
    const token = localStorage.getItem("token");
    if (!token) navigate("/login");
  }, [navigate]);

  // Fetch weather + forecast
  useEffect(() => {
    const apiKey = import.meta.env.VITE_OWM_KEY;
    if (!apiKey) return setError("Set VITE_OWM_KEY in .env");
    const lat = 52.2297, lon = 21.0122;
    axios
      .get("https://api.openweathermap.org/data/2.5/weather", { params: { lat, lon, units: "metric", appid: apiKey } })
      .then(res => {
        const w = res.data;
        const met = 1.1;
        const clo = w.main.temp <= 10 ? 1 : w.main.temp <= 20 ? 0.7 : 0.5;
        const v_air = Math.min(Math.max(w.wind.speed || 0.1, 0), 0.3);
        setParams({ met, clo, v_air });
        return axios.get("https://api.openweathermap.org/data/2.5/forecast", { params: { lat, lon, units: "metric", appid: apiKey } });
      })
      .then(res => setForecast(res.data))
      .catch(err => setError(err.message));
  }, []);

  // PMV notifications
  useEffect(() => {
    if (!params) return;
    const fetchPmv = () => {
      axios
        .get("http://127.0.0.1:7781/api/pmv", { params })
        .then(res => {
          const notes = res.data
            .filter(s => s.status !== "Comfortable")
            .map(s => ({ id: `aq-${s.id}`, sensor: s.name, message: `PMV is ${s.status}`, type: "AirQuality", severity: s.status }));
          setNotifications(prev => [...prev.filter(n => n.type !== "AirQuality"), ...notes]);
        })
        .catch(() => setError("Failed to fetch PMV data"));
    };
    fetchPmv();
    const iv = setInterval(fetchPmv, 600000);
    return () => clearInterval(iv);
  }, [params]);

  // Heater notifications
  useEffect(() => {
    const fetchHeater = () => {
      axios
        .get("http://127.0.0.1:7781/api/getSensorNotifications")
        .then(res => {
          const notes = res.data.flatMap(([id, name, , , tgt, tmp, bat]) => {
            const a = [];
            if (bat < 20) a.push({ id: `ht-batt-${id}`, sensor: name, message: `Battery low (${bat}%)`, type: "Heater", metric: "Battery", severity: "Moderate" });
            if (Math.abs(tmp - tgt) > 2) a.push({ id: `ht-temp-${id}`, sensor: name, message: `Temp off by ${Math.abs(tmp - tgt).toFixed(1)}°C`, type: "Heater", metric: "Temperature", severity: "Uncomfortable" });
            return a;
          });
          setNotifications(prev => [...prev.filter(n => n.type !== "Heater"), ...notes]);
        })
        .catch(() => setError("Failed to fetch Heater notifications"));
    };
    fetchHeater();
    const iv = setInterval(fetchHeater, 600000);
    return () => clearInterval(iv);
  }, []);

  // Energy notifications
  useEffect(() => {
    const fetchEnergy = () => {
      axios
        .get("http://127.0.0.1:7781/api/energy/notifications")
        .then(res => {
          const notes = res.data.map(n => ({ id: n.id, sensor: n.id, message: n.message, type: "EnergyMeter", metric: n.metric, severity: n.severity }));
          setNotifications(prev => [...prev.filter(n => n.type !== "EnergyMeter"), ...notes]);
        })
        .catch(() => setError("Failed to fetch EnergyMeter notifications"));
    };
    fetchEnergy();
    const iv = setInterval(fetchEnergy, 600000);
    return () => clearInterval(iv);
  }, []);

  const handleRemove = idx => setNotifications(n => n.filter((_, i) => i !== idx));
  const clearAll = () => setNotifications([]);

  // Filters
  let visible = notifications;
  if (sensorType !== "All") visible = visible.filter(n => n.type === sensorType);
  if (criteria) visible = visible.filter(n => n.metric ? n.metric === criteria : n.severity === criteria);

  // Group by sensor
  const grouped = visible.reduce((acc, note) => {
    acc[note.sensor] = acc[note.sensor] || [];
    acc[note.sensor].push(note);
    return acc;
  }, {});

  const next = forecast?.list?.[0];
  const city = forecast?.city?.name;

  const startDrag = (e) => {
    e.preventDefault();
    const startY = e.clientY;
    const startH = notificationsRef.current.getBoundingClientRect().height;
    const minH = window.innerHeight * 0.3;
    const onMouseMove = (e) => {
      const delta = startY - e.clientY;
      const newH = startH + delta;
      // clamp to [minH, full height]
      setPaneHeight(Math.max(minH, Math.min(window.innerHeight, newH)));
    };
    const onMouseUp = () => {
      window.removeEventListener("mousemove", onMouseMove);
      window.removeEventListener("mouseup", onMouseUp);
    };
    window.addEventListener("mousemove", onMouseMove);
    window.addEventListener("mouseup", onMouseUp);
  };

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
        {next && (
          <div style={styles.weatherCardSidebar}>
            <p style={styles.city}>{city}</p>
            <p style={styles.forecastTime}>{new Date(next.dt * 1000).toLocaleString()}</p>
            <img src={`https://openweathermap.org/img/wn/${next.weather[0].icon}@2x.png`} alt={next.weather[0].description} style={styles.icon} />
            <p style={styles.temp}>{next.main.temp.toFixed(1)}°C</p>
            <p style={styles.desc}>{next.weather[0].main}</p>
            <p style={styles.details}>Humidity: {next.main.humidity}% · Wind: {next.wind.speed} m/s</p>
          </div>
        )}
      </div>
        {/* Notifications header with filters */}
        <div  ref={notificationsRef} style={{...styles.notificationsContainer, height: paneHeight,}}>
          <div
          style={styles.resizeHandle}
          onMouseDown={startDrag}
          />
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

  );
}

const styles = {
  layout: { display: "flex", minHeight: "100vh" },
  sidebar: { width: "380px", background: "#34495e", color: "#fff", display: "flex", flexDirection: "column", padding: "2rem 1rem" },
  logo: {  margin: 0, marginBottom: "2rem", fontSize: "1.5rem", textAlign: "center"  },
  menu: { display: "flex", flexDirection: "column", gap: "1rem" },
  button: { fontSize: "1rem", background: "#2980b9", border: "none", color: "#fff", padding: "0.75rem", borderRadius: "6px", cursor: "pointer", textAlign: "left" },
  weatherCardSidebar: {
      marginTop: "auto",
      alignSelf: "center",
      background: "#fff",
      padding: "1rem",
      borderRadius: "12px",
      boxShadow: "0 4px 12px rgba(0,0,0,0.1)",
      textAlign: "center",
      width: "240px", 
      height: "260px",
    },
  city: { fontSize: "1.5rem", fontWeight: "bold", color: "#2c3e50" },
  forecastTime: { fontSize: "0.75rem", color: "#555" },
  icon: { width: "90px", height: "90px", margin: "0 0" },
  temp: { fontSize: "1.5rem", margin: "0 0" , color: "#555" },
  desc: { textTransform: "capitalize", color: "#555", margin: "0.25rem 0" },
  details: { fontSize: "0.75rem", color: "#777" },
  notificationsContainer: {
    position: "fixed",
    bottom: 0,
    left: "380px",
    right: 0,
    background: "#f9f9f9",
    padding: "1rem",
    paddingTop: "1rem",     // leave room for the handle
    borderTop: "1px solid #ddd",
    display: "flex",
    flexDirection: "column",
    zIndex: 100,
    overflow: "hidden",     // we’ll handle scrolling inside
  },
  resizeHandle: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    height: "6px",          // grab‑area thickness
    cursor: "ns-resize",
    background: "transparent",
    zIndex: 101,
  },
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
