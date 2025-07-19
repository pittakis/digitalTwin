import { useEffect, useState } from "react";
import axios from "axios";

export default function SensorStatusGrid({ onSelect, aiEnabled }) {
  const [statuses, setStatuses] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    console.log("aiEnabled:", aiEnabled);
    axios
      .get("http://localhost:7781/api/sensor/status/" + aiEnabled)
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
    gridTemplateColumns: "repeat(auto-fill, minmax(240px, 1fr))",
    gap: "1rem",
    marginBottom: "1rem",
  },
  card: {
    width: "100%",
    minWidth: "240px",         // full width
    display: "flex",
    alignItems: "center",
    background: "rgba(214, 214, 214, 1)",
    padding: "0.3rem",
    borderRadius: "8px",
    boxShadow: "0 2px 8px rgba(148, 148, 148, 0.05)",
    cursor: "pointer",
  },
  led: {
    width: "13px",
    height: "13px",
    borderRadius: "50%",
    marginRight: "0.75rem",
  },
  info: {
    fontSize: "15px",
    display: "flex",
    flexDirection: "column",
  },
};