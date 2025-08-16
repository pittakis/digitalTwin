import { useState } from "react";
import axios from "axios";

function Login() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    try {
      const res = await axios.post("http://localhost:7781/api/v1/login", new URLSearchParams({
        username,
        password
      }));
      localStorage.setItem("token", res.data.access_token);
      alert("Login successful");
      window.location.href = "/dashboard"; // Replace with your actual route
    } catch (err) {
      setError("Invalid credentials. Please try again.");
    }
  };

  return (
    <div style={styles.container}>
      <form onSubmit={handleSubmit} style={styles.form}>
        <h2 style={styles.title}>Login</h2>
        {error && <p style={styles.error}>{error}</p>}
        <input
          style={styles.input}
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <input
          type="password"
          style={styles.input}
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button type="submit" style={styles.button}>Login</button>
      </form>
    </div>
  );
}

const styles = {
  container: {
    minHeight: "100vh",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    background: "linear-gradient(to right, #2c3e50, #4ca1af)",
    fontFamily: "Segoe UI, sans-serif",
  },
  form: {
    background: "white",
    padding: "2rem",
    borderRadius: "12px",
    boxShadow: "0 4px 20px rgba(0,0,0,0.2)",
    width: "100%",
    maxWidth: "400px",
    display: "flex",
    flexDirection: "column",
  },
  title: {
    textAlign: "center",
    marginBottom: "1.5rem",
    color: "#333",
  },
  input: {
    padding: "0.8rem",
    marginBottom: "1rem",
    borderRadius: "8px",
    border: "1px solid #ccc",
    fontSize: "1rem",
  },
  button: {
    padding: "0.8rem",
    background: "#3498db",
    color: "white",
    border: "none",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "1rem",
    fontWeight: "bold",
  },
  error: {
    color: "red",
    marginBottom: "1rem",
    textAlign: "center",
  },
};

export default Login;
