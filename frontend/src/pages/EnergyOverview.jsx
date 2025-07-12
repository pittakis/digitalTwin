import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from 'react-router-dom';


function EnergyOverview() {
  const navigate = useNavigate();
  const [data, setData] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchData = async () => {
    try {
      const res = await axios.get("http://localhost:7781/api/energy");
      setData(res.data);
      setError(null);
    } catch (err) {
      setError("⚠️ Failed to fetch energy data.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
    const interval = setInterval(fetchData, 10000);
    return () => clearInterval(interval);
  }, []);

  const renderCard = (id, info) => (
  <div key={id} style={styles.card}>
    <h3 style={styles.cardTitle}>🔌 {info.name || "Unnamed Sensor"}</h3>
    <p><strong>Sensor ID:</strong> {id}</p>
    <p><strong>Type:</strong> {info.type}</p>
    <p><strong>Timestamp:</strong> {info.timestamp ? new Date(info.timestamp).toLocaleString() : "N/A"}</p>
    <p><strong>Active Power:</strong> {info.total_active_power_kw} kW</p>
    <p><strong>Power Factor:</strong> {info.power_factor}</p>
  </div>
  );

  return (
    <div style={styles.container}>
      <button
        onClick={() => navigate(-1)}
        style={styles.backBtn}
        aria-label="Go back"
      >
        ⬅ Back
      </button>


      <h2 style={styles.header}>⚡ Energy Meter Overview</h2>
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
    background: "#f9fafb",
    minHeight: "100vh",
  },
  header: {
    fontSize: "1.75rem",
    marginBottom: "1.5rem",
  },
  grid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(280px, 1fr))",
    gap: "1.5rem",
  },
  card: {
    background: "#fff",
    borderRadius: "1rem",
    boxShadow: "0 4px 12px rgba(0,0,0,0.05)",
    padding: "1.5rem",
    transition: "transform 0.2s",
  },
  cardTitle: {
    marginBottom: "0.75rem",
    fontSize: "1.2rem",
    color: "#333",
  },
  error: {
    color: "crimson",
    fontWeight: 500,
  },
  backBtn: {
    background: "none",
    border: "none",
    cursor: "pointer",
    fontSize: "1rem",
    marginBottom: "1rem",
    color: "#007BFF",
  }
};

export default EnergyOverview;
