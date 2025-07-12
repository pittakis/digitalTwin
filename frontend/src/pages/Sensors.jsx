import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

function Sensors() {
  const [sensorData, setSensorData] = useState({});
  const [expandedRows, setExpandedRows] = useState({});
  const [searchTerm, setSearchTerm] = useState("");
  const navigate = useNavigate();

  const fetchSensors = async () => {
    try {
      const res = await axios.get("http://localhost:7781/api/sensors");
      setSensorData(res.data);
    } catch (err) {
      console.error("Sensor fetch failed", err);
    }
  };

  useEffect(() => {
    fetchSensors();
    const interval = setInterval(fetchSensors, 5000);
    return () => clearInterval(interval);
  }, []);

  const toggleRow = (id) => {
    setExpandedRows((prev) => ({
      ...prev,
      [id]: !prev[id],
    }));
  };

  const renderTable = (category) => {
    const items = (sensorData[category] || []).filter((item) =>
      item.name.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
      <div key={category} style={{ marginTop: "3rem" }}>
        <h3 style={styles.heading}>{category}</h3>
        {items.length === 0 ? (
          <p style={{ fontStyle: "italic", color: "#666" }}>No data available.</p>
        ) : (
          <table style={styles.table}>
            <thead>
              <tr>
                <th style={styles.th}>Data</th>
                <th style={styles.th}>Name</th>
                <th style={styles.th}>Location</th>
                <th style={styles.th}>Last Updated</th>
              </tr>
            </thead>
            <tbody>
              {items.map((device, index) => {
                const isExpanded = expandedRows[device.id];
                const data = device.latest_data || {};

                return (
                  <Fragment key={device.id}>
                    <tr style={index % 2 === 0 ? styles.rowEven : styles.rowOdd}>
                      <td style={styles.td}>
                        <button
                          onClick={() => toggleRow(device.id)}
                          style={{
                            ...styles.toggleBtn,
                            backgroundColor: isExpanded ? "#dc3545" : "#28a745",
                          }}
                        >
                          {isExpanded ? "−" : "+"}
                        </button>
                      </td>
                      <td style={styles.td}>{device.name}</td>
                      <td style={styles.td}>{device.location}</td>
                      <td style={styles.td}>
                        {device.last_updated
                          ? new Date(device.last_updated).toLocaleString()
                          : "N/A"}
                      </td>
                    </tr>
                    {isExpanded && (
                      <tr>
                        <td colSpan="4" style={styles.expandedRow}>
                          {Object.keys(data).length ? (
                            <ul style={styles.dataList}>
                              {Object.entries(data).map(([key, val]) => (
                                <li key={key}>
                                  <strong>{key}:</strong> {val?.toString()}
                                </li>
                              ))}
                            </ul>
                          ) : (
                            <em style={{ color: "#777" }}>No sensor data</em>
                          )}
                        </td>
                      </tr>
                    )}
                  </Fragment>
                );
              })}
            </tbody>
          </table>
        )}
      </div>
    );
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
      <h2>📡 Sensor Data</h2>

      <input
        type="text"
        placeholder="Filter by name..."
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        style={styles.search}
      />

      {["AirQuality", "Heater", "EnergyMeter"].map(renderTable)}
    </div>
  );
}

import { Fragment } from "react";

const styles = {
  page: {
    padding: "2rem",
    fontFamily: "Segoe UI, sans-serif",
  },
  heading: {
    borderBottom: "2px solid #007BFF",
    paddingBottom: "0.25rem",
    marginBottom: "0.5rem",
  },
  table: {
    width: "100%",
    borderCollapse: "collapse",
    boxShadow: "0 2px 8px rgba(0,0,0,0.1)",
  },
  th: {
    backgroundColor: "#f0f4f8",
    padding: "0.75rem",
    borderBottom: "1px solid #ddd",
    textAlign: "left",
  },
  td: {
    padding: "0.75rem",
    borderBottom: "1px solid #eee",
    verticalAlign: "top",
  },
  rowEven: {
    backgroundColor: "#fafafa",
  },
  rowOdd: {
    backgroundColor: "#fff",
  },
  toggleBtn: {
    border: "none",
    padding: "0.3rem 0.6rem",
    color: "#fff",
    fontWeight: "bold",
    borderRadius: "4px",
    cursor: "pointer",
    fontSize: "1.1rem",
  },
  expandedRow: {
    backgroundColor: "#f9f9f9",
    padding: "1rem",
  },
  dataList: {
    display: "grid",
    gridTemplateColumns: "repeat(5, 1fr)",  // 5 items per row
    gap: "1rem",
    margin: "0.5rem 0.5rem",
    padding: "0.5rem",
    border: "3px solid #ddd",
    borderColor: "black",
    borderRadius: "6px",
    backgroundColor: "lightgrey",
    listStyleType: "none",
  },
  backBtn: {
    background: "none",
    border: "none",
    cursor: "pointer",
    fontSize: "1rem",
    marginBottom: "1rem",
    color: "#007BFF",
  },
  search: {
    padding: "0.5rem 0.75rem",
    width: "100%",
    maxWidth: "300px",
    fontSize: "1rem",
    marginBottom: "1rem",
    borderRadius: "6px",
    border: "1px solid #ccc",
  },
};

export default Sensors;
