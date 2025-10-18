import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const API_BASE = "http://localhost:7781/api/v1";

function Login() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);
  const [isSignup, setIsSignup] = useState(false);
  const navigate = useNavigate();

  const resetForm = () => {
    setUsername("");
    setPassword("");
    setConfirmPassword("");
    setError("");
    setMessage("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setMessage("");

    if (isSignup && password !== confirmPassword) {
      setError("Passwords do not match. Please try again.");
      return;
    }

    setLoading(true);

    try {
      const body = new URLSearchParams();
      body.append("username", username);
      body.append("password", password);

      if (isSignup) {
        await axios.post(`${API_BASE}/signup`, body, {
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
        });

        setMessage("Account created! Waiting for admin approval.");
        setTimeout(() => {
          setIsSignup(false);
          resetForm();
        }, 2500);
      } else {
        const res = await axios.post(`${API_BASE}/login`, body, {
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
        });

        const token = res.data && res.data.access_token;
        if (!token) throw new Error("No token in response");
        console.log(res.data);
        sessionStorage.setItem("token", token);
        sessionStorage.setItem("role", res.data.role);
        navigate("/dashboard");
      }
    } catch (err) {
      const detail =
        (err.response && err.response.data && err.response.data.detail) ||
        err.message ||
        "Something went wrong. Please try again.";
      setError(detail);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={styles.container}>
      <form onSubmit={handleSubmit} style={styles.form}>
        <h2 style={styles.title}>{isSignup ? "Sign Up" : "Login"}</h2>

        {error && <p style={styles.error}>{error}</p>}
        {message && <p style={styles.success}>{message}</p>}

        <input
          style={styles.input}
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          autoComplete="username"
          required
        />

        <input
          type="password"
          style={styles.input}
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          autoComplete={isSignup ? "new-password" : "current-password"}
          required
        />

        {isSignup && (
          <input
            type="password"
            style={styles.input}
            placeholder="Confirm Password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            autoComplete="new-password"
            required
          />
        )}

        <button type="submit" style={styles.button} disabled={loading}>
          {loading
            ? isSignup
              ? "Creating..."
              : "Logging in..."
            : isSignup
            ? "Create Account"
            : "Login"}
        </button>

        <p style={styles.switchText}>
          {isSignup ? (
            <>
              Already have an account?{" "}
              <button
                type="button"
                onClick={() => {
                  setIsSignup(false);
                  resetForm();
                }}
                style={styles.linkButton}
              >
                Login
              </button>
            </>
          ) : (
            <>
              Don’t have an account?{" "}
              <button
                type="button"
                onClick={() => {
                  setIsSignup(true);
                  resetForm();
                }}
                style={styles.linkButton}
              >
                Sign up
              </button>
            </>
          )}
        </p>
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
    background: "linear-gradient(135deg, #2c3e50, #4ca1af)",
    fontFamily: "Segoe UI, sans-serif",
    padding: "1rem",
  },
  form: {
    background: "white",
    padding: "2.5rem",
    borderRadius: "16px",
    boxShadow: "0 6px 25px rgba(0,0,0,0.25)",
    width: "100%",
    maxWidth: "400px",
    display: "flex",
    flexDirection: "column",
    transition: "all 0.3s ease",
  },
  title: {
    textAlign: "center",
    marginBottom: "1.5rem",
    color: "#333",
    fontSize: "1.8rem",
  },
  input: {
    padding: "0.8rem 1rem",
    marginBottom: "1rem",
    borderRadius: "8px",
    border: "1px solid #ccc",
    fontSize: "1rem",
    outline: "none",
    transition: "border-color 0.2s ease",
  },
  button: {
    padding: "0.9rem",
    background: "#3498db",
    color: "white",
    border: "none",
    borderRadius: "8px",
    cursor: "pointer",
    fontSize: "1rem",
    fontWeight: "bold",
    transition: "background 0.3s ease",
  },
  error: {
    color: "red",
    marginBottom: "1rem",
    textAlign: "center",
    fontWeight: "500",
  },
  success: {
    color: "green",
    marginBottom: "1rem",
    textAlign: "center",
    fontWeight: "500",
  },
  switchText: {
    textAlign: "center",
    marginTop: "1rem",
    color: "#555",
  },
  linkButton: {
    background: "none",
    border: "none",
    color: "#3498db",
    cursor: "pointer",
    fontWeight: "bold",
    textDecoration: "underline",
  },
};

export default Login;
