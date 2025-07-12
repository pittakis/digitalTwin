import { useEffect } from "react";
import { useNavigate } from "react-router-dom";

function Dashboard() {
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem("token");
    if (!token) {
      navigate("/login");
    }
  }, [navigate]);

  return (
    <div style={styles.container}>
      <div style={styles.card}>
        <h1 style={styles.title}>Digital Twin Dashboard</h1>
        <div style={styles.menu}>
          <button onClick={() => navigate("/sensors")} style={styles.button}>
            📊 Sensor Data
          </button>
          <button onClick={() => navigate("/energy-overview")} style={styles.button}>
            ⚡ Energy Overview
          </button>
          <button onClick={() => navigate("/heater-overview")} style={styles.button}>
            🔥 Heater Overview
          </button>
          <button onClick={() => navigate("/pmv")} style={styles.button}>
            🌡️ PMV Calculator
          </button>
          <button onClick={() => navigate("/building-3d")} style={styles.button}>
            🏗️ 3D Building View
          </button>
        </div>
      </div>
    </div>
  );
}

const styles = {
  container: {
    minHeight: "100vh",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    background: "#ecf0f1",
    fontFamily: "Segoe UI, sans-serif",
  },
  card: {
    background: "white",
    padding: "2rem",
    borderRadius: "16px",
    boxShadow: "0 4px 16px rgba(0,0,0,0.1)",
    width: "100%",
    maxWidth: "500px",
    textAlign: "center",
  },
  title: {
    marginBottom: "2rem",
    color: "#2c3e50",
  },
  menu: {
    display: "flex",
    flexDirection: "column",
    gap: "1rem",
  },
  button: {
    padding: "1rem",
    fontSize: "1rem",
    borderRadius: "10px",
    border: "none",
    background: "#2980b9",
    color: "white",
    cursor: "pointer",
    transition: "0.3s",
  },
};

export default Dashboard;
