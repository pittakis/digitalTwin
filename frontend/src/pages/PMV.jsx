import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

// Utility: row background based on status
const getRowColor = (status, showColors) => {
  if (!showColors) return {};
  switch (status) {
    case "Comfortable":
      return { backgroundColor: "#d4edda" };
    case "Moderate":
      return { backgroundColor: "#fff3cd" };
    case "Uncomfortable":
      return { backgroundColor: "#f8d7da" };
    default:
      return {};
  }
};

// Utility: status text color
const getStatusColor = (status) => {
  switch (status) {
    case "Comfortable":
      return "#2e7d32"; // green
    case "Moderate":
      return "#b45f06"; // orange
    case "Uncomfortable":
      return "#a71d2a"; // red
    default:
      return "#000";
  }
};

// Compute clothing insulation based on outdoor temperature (°C)
const computeClo = (temp) => {
  if (temp <= 10) return 1.0;
  if (temp <= 20) return 0.7;
  return 0.5;
};

export default function PMV() {
  const [pmvData, setPmvData] = useState([]);
  const [error, setError] = useState(null);
  const [showColors, setShowColors] = useState(false);
  const [params, setParams] = useState(null);
  const navigate = useNavigate();

  // Fetch weather once, compute PMV params
  useEffect(() => {
    const apiKey = import.meta.env.VITE_OWM_KEY;
    const lat = 52.2297;
    const lon = 21.0122;
    const weatherUrl = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&units=metric&appid=${apiKey}`;

    axios.get(weatherUrl)
      .then(res => {
        const w = res.data;
        const met = 1.1;  // metabolic rate (met)
        const clo = computeClo(w.main.temp);
        const v_air = Math.min(Math.max(w.wind.speed || 0.1, 0), 0.3);
        setParams({ met, clo, v_air });
      })
      .catch(() => setError("Failed to load weather data"));
  }, []);

  // Fetch PMV once with computed params
  useEffect(() => {
    if (!params) return;
    axios.get("http://localhost:7781/api/pmv", { params })
      .then(res => setPmvData(res.data))
      .catch(() => setError("Failed to fetch PMV data"));
  }, [params]);

  return (
    <div style={styles.page}>
      <button onClick={() => navigate(-1)} style={styles.backBtn} aria-label="Go back">
        ⬅ Back
      </button>

      <h2 style={styles.title}>📋 PMV Sensor List</h2>
      {error && <p style={styles.error}>{error}</p>}

      {/* Controls with parameter badges */}
      <div style={styles.controls}>
        <button onClick={() => setShowColors(prev => !prev)} style={styles.toggleBtn}>
          {showColors ? "Hide Colors" : "Show Colors"}
        </button>
        {params && (
          <div style={styles.badges}>
            <span style={styles.badge}>
              Metabolic Rate: {params.met}
            </span>
            <span style={styles.badge}>
              Clothing Insulation: {params.clo}
            </span>
            <span style={styles.badge}>
              Air Velocity: {params.v_air} m/s
            </span>
          </div>
        )}
      </div>

      <table style={styles.table}>
        <thead>
          <tr>
            <th style={styles.th}>Sensor ID</th>
            <th style={styles.th}>Timestamp</th>
            <th style={styles.th}>Name</th>
            <th style={styles.th}>Temperature (°C)</th>
            <th style={styles.th}>Humidity (%)</th>
            <th style={styles.th}>PMV</th>
            <th style={styles.th}>PPD (%)</th>
            <th style={styles.th}>Status</th>
          </tr>
        </thead>
        <tbody>
          {pmvData.map((sensor, idx) => (
            <tr key={sensor.id} style={{
                ...(idx % 2 === 0 ? styles.rowEven : styles.rowOdd),
                ...getRowColor(sensor.status, showColors),
              }}>
              <td style={styles.td}>{sensor.id}</td>
              <td style={styles.td}>{sensor.timestamp ? new Date(sensor.timestamp).toLocaleString() : "-"}</td>
              <td style={styles.td}>{sensor.name}</td>
              <td style={styles.td}>{sensor.temperature ?? "-"}</td>
              <td style={styles.td}>{sensor.humidity ?? "-"}</td>
              <td style={styles.td}>{sensor.pmv}</td>
              <td style={styles.td}>{sensor.ppd}</td>
              <td style={{ ...styles.td, fontWeight: "bold", color: getStatusColor(sensor.status) }}>
                {sensor.status}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

const styles = {
  page: {
    padding: "2rem",
    fontFamily: "Segoe UI, sans-serif",
  },
  title: {
    marginBottom: "1rem",
    color: "#2c3e50",
  },
  backBtn: {
    background: "none",
    border: "none",
    cursor: "pointer",
    fontSize: "1rem",
    marginBottom: "1rem",
    color: "#007BFF",
  },
  controls: {
    display: "flex",
    alignItems: "center",
    gap: "1rem",
    marginBottom: "1rem",
  },
  toggleBtn: {
    backgroundColor: "#007BFF",
    color: "#fff",
    padding: "0.5rem 1rem",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
    fontSize: "1rem",
  },
  badges: {
    display: "flex",
    gap: "0.5rem",
  },
  badge: {
    backgroundColor: "#e0e0e0",
    padding: "0.3rem 0.6rem",
    borderRadius: "12px",
    fontSize: "0.85rem",
    color: "#333",
  },
  table: {
    width: "100%",
    borderCollapse: "collapse",
    borderRadius: "12px",
    overflow: "hidden",
    boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
  },
  th: {
    backgroundColor: "#f0f4f8",
    padding: "0.75rem",
    borderBottom: "1px solid #ddd",
    textAlign: "center",
  },
  td: {
    padding: "0.75rem",
    borderBottom: "1px solid #eee",
    textAlign: "center",
  },
  rowEven: {
    backgroundColor: "#fafafa",
  },
  rowOdd: {
    backgroundColor: "#fff",
  },
  error: {
    color: "crimson",
    marginBottom: "1rem",
  },
};
