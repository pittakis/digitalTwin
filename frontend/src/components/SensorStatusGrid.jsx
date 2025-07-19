import { useEffect, useState } from "react";
import axios from "axios";

export default function SensorStatusGrid({ onSelect }) {
  const [statuses, setStatuses] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    axios
      .get("http://localhost:7781/api/sensor/status")
      .then(({ data }) => setStatuses(data))
      .catch(err => setError("Failed to load sensor statuses"));
  }, []);

  // pick LED color
  const getColor = (sensor) => {
    return sensor.status
  };

  if (error) return <p style={{ color: "crimson" }}>{error}</p>;

  return (
    <div style={gridStyles.container}>
      {statuses.map(sensor => {
        const color = getColor(sensor);
        return (
          <div
            key={sensor.id}
            onClick={() => onSelect(sensor)}
            style={gridStyles.card}
          >
            <div
              style={{
                ...gridStyles.led,
                backgroundColor: color,
              }}
            />
            <div style={gridStyles.info}>
              <strong>{sensor.name}</strong>
              <small style={{ color: "#666" }}>{sensor.type}</small>
            </div>
          </div>
        );
      })}
    </div>
  );
}

const gridStyles = {
  container: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fill, minmax(250px, 1fr))",
    gap: "1rem",
    marginBottom: "2rem",
  },
  card: {
    width: "100%",                 // full width
    display: "flex",
    alignItems: "center",
    background: "lightgray",
    padding: "0.75rem",
    borderRadius: "8px",
    boxShadow: "0 2px 8px rgba(0,0,0,0.05)",
    cursor: "pointer",
  },
  led: {
    width: "12px",
    height: "12px",
    borderRadius: "50%",
    marginRight: "0.75rem",
  },
  info: {
    display: "flex",
    flexDirection: "column",
  },
};