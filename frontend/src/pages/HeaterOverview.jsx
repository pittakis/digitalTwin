import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from 'react-router-dom';

function HeaterOverview() {
  const navigate = useNavigate();
  const [data, setData] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Calculate temperature gap
  const calcTempGap = (target, actual) => (target - actual).toFixed(2);

  const fetchData = async () => {
    try {
      const res = await axios.get("http://localhost:7781/api/heater");
      setData(res.data);
      setError(null);
    } catch (err) {
      setError("⚠️ Failed to fetch heater data.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
    const interval = setInterval(fetchData, 10000); // refresh every 10s
    return () => clearInterval(interval);
  }, []);

  const renderCard = (id, info) => {
    const val = info.Measurements[0].Value;
    const tempGap = calcTempGap(val.TargetTemperature, val.Temperature);

    return (
      <div key={id} style={styles.card}>
        <h3 style={styles.cardTitle}>🔥 {id}</h3>
        <p><strong>Name:</strong> {info.Name}</p>
        <p><strong>Timestamp:</strong> {new Date(info.Timestamp).toLocaleString()}</p>
        <p><strong>Valve Position:</strong> {val.ValvePosition}%</p>
        <p><strong>Target Temperature:</strong> {val.TargetTemperature} °C</p>
        <p><strong>Current Temperature:</strong> {val.Temperature} °C</p>
        <p><strong>Battery:</strong> {val.Battery} %</p>
        <hr />
        <p><strong>Temperature Gap:</strong> {tempGap} °C</p>
      </div>
    );
  };

  return (
    <div style={styles.container}>
      <button
        onClick={() => navigate(-1)}
        style={styles.backBtn}
        aria-label="Go back"
      >
        ⬅ Back
      </button>
      <h2 style={styles.header}>🔥 Heater Sensors Overview</h2>
      {loading && <p>Loading data...</p>}
      {error && <p style={styles.error}>{error}</p>}
      <div style={styles.grid}>
        {Object.entries(data).map(([id, info]) => renderCard(id, info))}
      </div>
    </div>
  );
}

const styles = {
  container: {
    padding: "2rem",
    fontFamily: "Segoe UI, sans-serif",
    background: "#f7f8fa",
    minHeight: "100vh",
  },
  header: {
    fontSize: "1.8rem",
    marginBottom: "1.5rem",
    color: "#d9534f", // subtle red for heater
  },
  grid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(340px, 1fr))",
    gap: "1.5rem",
  },
  card: {
    background: "#fff",
    borderRadius: "1rem",
    boxShadow: "0 4px 15px rgba(217,83,79,0.1)",
    padding: "1.75rem",
    transition: "transform 0.2s",
  },
  cardTitle: {
    marginBottom: "1rem",
    fontSize: "1.3rem",
    color: "#c9302c",
  },
  error: {
    color: "crimson",
    fontWeight: 600,
  },
  backBtn: {
    background: "none",
    border: "none",
    cursor: "pointer",
    fontSize: "1rem",
    marginBottom: "1rem",
    color: "#007BFF",
  },
};

export default HeaterOverview;
