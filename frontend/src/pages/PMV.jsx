import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

function PMV() {
  const [data, setData] = useState([]);
  const [showColors, setShowColors] = useState(false);
  const navigate = useNavigate();

  const fetchData = async () => {
    try {
      const res = await axios.get("http://localhost:7781/api/pmv");
      const formatted = Object.entries(res.data).map(([sensor_id, values]) => ({
        sensor_id,
        ...values,
      }));
      setData(formatted);
    } catch (err) {
      console.error("Failed to fetch PMV data", err);
    }
  };

  useEffect(() => {
    fetchData();
    const interval = setInterval(fetchData, 5000);
    return () => clearInterval(interval);
  }, []);

  const getRowColor = (status) => {
    if (!showColors) return {};
    if (status === "Comfortable") return { backgroundColor: "#d4edda" }; // green-ish
    if (status === "Critical") return { backgroundColor: "#fff3cd" }; // yellow-ish
    return { backgroundColor: "#f8d7da" }; // red-ish
  };

  return (
    <div style={styles.page}>
      <button
        onClick={() => navigate(-1)}
        style={styles.backBtn}
        aria-label="Go back"
      >
        ⬅ Back
      </button>

      <h2 style={styles.title}>📋 PMV Sensor List</h2>

      <button onClick={() => setShowColors(!showColors)} style={styles.toggleBtn}>
        {showColors ? "Hide Colors" : "Show Colors"}
      </button>

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
          {data.map((sensor, index) => (
            <tr
              key={sensor.sensor_id}
              style={{
                ...styles.row,
                ...(index % 2 === 0 ? styles.rowEven : styles.rowOdd),
                ...getRowColor(sensor.status),
              }}
            >
              <td style={styles.td}>{sensor.sensor_id}</td>
              <td style={styles.td}>{new Date(sensor.timestamp).toLocaleString()}</td>
              <td style={styles.td}>{sensor.name}</td>
              <td style={styles.td}>{sensor.temperature}</td>
              <td style={styles.td}>{sensor.humidity}</td>
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

// Utility: status font color
const getStatusColor = (status) => {
  if (status === "Comfortable") return "#2e7d32"; // green
  if (status === "Critical") return "#b45f06"; // orange
  return "#a71d2a"; // red
};

const styles = {
  page: {
    padding: "2rem",
    fontFamily: "Segoe UI, sans-serif",
  },
  title: {
    marginBottom: "1rem",
  },
  backBtn: {
    background: "none",
    border: "none",
    cursor: "pointer",
    fontSize: "1rem",
    marginBottom: "1rem",
    color: "#007BFF",
  },
  toggleBtn: {
    backgroundColor: "#007BFF",
    color: "#fff",
    padding: "0.5rem 1rem",
    marginBottom: "1rem",
    border: "none",
    borderRadius: "6px",
    cursor: "pointer",
    fontSize: "1rem",
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
  row: {
    transition: "background-color 0.3s ease",
  },
  rowEven: {
    backgroundColor: "#fafafa",
  },
  rowOdd: {
    backgroundColor: "#fff",
  },
};

export default PMV;
