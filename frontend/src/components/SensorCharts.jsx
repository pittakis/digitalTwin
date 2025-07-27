import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
  CartesianGrid,
  ResponsiveContainer
} from 'recharts';
import { useEffect, useState } from "react";
import axios from "axios";

function SensorChart({ sensorId }) {
  const [data, setData] = useState([]);

  useEffect(() => {
    if (!sensorId) return;
    axios.get(`http://localhost:7781/api/sensor/history/${sensorId}`)
      .then(res => {
        const processed = res.data.map(entry => ({
          timestamp: new Date(entry.timestamp).toLocaleTimeString(),
          ...entry.data,
        }));
        setData(processed);
      })
      .catch(err => console.error("Failed to fetch history:", err));
  }, [sensorId]);

  if (!data.length) return <p>No historical data available.</p>;

  const keys = Object.keys(data[0]).filter(k => k !== "timestamp");

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: "2rem" }}>
      <h3>Data Charts</h3>
      {keys.map((key) => (
        <div key={key}>
          <h4 style={{ marginBottom: "0.5rem" }}>{key.toUpperCase()}</h4>
          <ResponsiveContainer width="100%" height={250}>
            <LineChart data={data}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="timestamp" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Line
                type="monotone"
                dataKey={key}
                stroke="#10a01cff"
                dot={false}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      ))}
    </div>
  );
}

export default SensorChart;
