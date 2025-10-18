import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { Check, X, Trash } from "lucide-react";

const UsersManagement = () => {
  const navigate = useNavigate();
  const [users, setUsers] = useState([]);
  const [pending, setPending] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const token = sessionStorage.getItem("token");

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const res = await axios.get("http://localhost:7781/api/v1/getAllUsers", {
        headers: { Authorization: `Bearer ${token}` },
      });
      setUsers(res.data.users);
      setPending(res.data.pending);
      setError(null);
    } catch (err) {
      console.error(err);
      setError("Failed to fetch users.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleAction = async (tempId, approve) => {
    try {
      await axios.post(
        "http://localhost:7781/api/v1/users/action",
        { temp_id: tempId, approve },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      fetchUsers();
    } catch (err) {
      console.error(err);
      setError("Action failed.");
    }
  };

  const handleDeleteUser = async (userId, username) => {
    if (!window.confirm(`Are you sure you want to delete user ${username}?`)) return;

    try {
      const res = await axios.post(
        "http://localhost:7781/api/v1/users/delete",
        { user_id: userId, username },
        { headers: { Authorization: `Bearer ${token}` } }
      );

      if (res.data && res.data.message) alert(res.data.message);
      if (res.data.success) fetchUsers();
    } catch (err) {
      console.error(err);
      setError("Failed to delete user.");
    }
  };

  return (
    <div style={styles.page}>
      {/* Sticky header */}
      <div style={styles.header}>
        <button onClick={() => navigate(-1)} style={styles.backBtn} aria-label="Go back">
          ⬅ Back
        </button>
        <h2 style={styles.headerTitle}>👤 Users Management</h2>
      </div>

      <div style={styles.scrollArea}>
        {loading && <p>Loading users...</p>}
        {error && <p style={styles.error}>{error}</p>}

        {/* Tables container */}
        <div style={styles.tablesContainer}>
          {/* Existing Users */}
          <div style={styles.tableWrapper}>
            <h3 style={styles.tableTitle}>Users</h3>
            <div style={{ overflowX: "auto" }}>
              <table style={styles.table}>
                <thead>
                  <tr>
                    <th style={styles.th}>ID</th>
                    <th style={styles.th}>Username</th>
                    <th style={styles.th}>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {users.map((u) => (
                    <tr key={u.id} style={styles.rowEven}>
                      <td style={styles.td}>{u.id}</td>
                      <td style={styles.td}>{u.username}</td>
                      <td style={styles.td}>
                        <button
                          style={styles.deleteBtn}
                          onClick={() => handleDeleteUser(u.id, u.username)}
                        >
                          <Trash size={16} />
                        </button>
                      </td>
                    </tr>
                  ))}
                  {users.length === 0 && (
                    <tr>
                      <td colSpan={3} style={styles.td}>
                        No users found.
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>

          {/* Pending Approvals */}
          <div style={styles.tableWrapper}>
            <h3 style={styles.tableTitle}>Pending Approvals</h3>
            <div style={{ overflowX: "auto" }}>
              <table style={styles.table}>
                <thead>
                  <tr>
                    <th style={styles.th}>ID</th>
                    <th style={styles.th}>Username</th>
                    <th style={styles.th}>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {pending.map((u) => (
                    <tr key={u.id} style={styles.rowOdd}>
                      <td style={styles.td}>{u.id}</td>
                      <td style={styles.td}>{u.username}</td>
                      <td style={styles.td}>
                        <button
                          style={styles.approveBtn}
                          onClick={() => handleAction(u.id, true)}
                        >
                          <Check size={16} />
                        </button>
                        <button
                          style={styles.rejectBtn}
                          onClick={() => handleAction(u.id, false)}
                        >
                          <X size={16} />
                        </button>
                      </td>
                    </tr>
                  ))}
                  {pending.length === 0 && (
                    <tr>
                      <td colSpan={3} style={styles.td}>
                        No pending approvals.
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

const styles = {
  page: {
    display: "flex",
    flexDirection: "column",
    height: "100vh",
    fontFamily: "Segoe UI, sans-serif",
  },
  header: {
    display: "flex",
    alignItems: "center",
    gap: "1rem",
    padding: "1rem 2rem",
    borderBottom: "1px solid #ddd",
    background: "#fff",
    position: "sticky",
    top: 0,
    zIndex: 10,
  },
  headerTitle: {
    margin: 0,
    fontSize: "1.5rem",
    flex: 1,
    textAlign: "center",
  },
  backBtn: {
    background: "none",
    border: "none",
    cursor: "pointer",
    fontSize: "1rem",
    color: "#007BFF",
  },
  scrollArea: {
    flex: "1 1 auto",
    overflow: "auto",
    padding: "1rem 2rem 2rem",
  },
  tablesContainer: {
    display: "flex",
    gap: "2rem",
    flexWrap: "wrap",
    justifyContent: "space-between",
  },
  tableWrapper: {
    flex: "1 1 48%",
    minWidth: "320px",
  },
  tableTitle: {
    textAlign: "center",
    marginBottom: "0.5rem",
  },
  table: {
    width: "100%",
    borderCollapse: "collapse",
    boxShadow: "0 2px 8px rgba(217,83,79,0.1)",
    background: "#fff",
    borderRadius: "12px",
    overflow: "hidden",
  },
  th: {
    backgroundColor: "#f0f4f8",
    padding: "0.75rem",
    borderBottom: "1px solid #ddd",
    textAlign: "center",
    whiteSpace: "nowrap",
  },
  td: {
    padding: "0.75rem",
    borderBottom: "1px solid #eee",
    textAlign: "center",
  },
  rowEven: { backgroundColor: "#fff" },
  rowOdd: { backgroundColor: "#fafafa" },
  approveBtn: {
    marginRight: "0.5rem",
    padding: "0.25rem 0.5rem",
    backgroundColor: "#28a745",
    border: "none",
    borderRadius: "6px",
    color: "#fff",
    cursor: "pointer",
  },
  rejectBtn: {
    padding: "0.25rem 0.5rem",
    backgroundColor: "#dc3545",
    border: "none",
    borderRadius: "6px",
    color: "#fff",
    cursor: "pointer",
  },
  deleteBtn: {
    padding: "0.25rem 0.5rem",
    backgroundColor: "#ff851b",
    border: "none",
    borderRadius: "6px",
    color: "#fff",
    cursor: "pointer",
  },
  error: {
    color: "crimson",
    fontWeight: 600,
  },
};

export default UsersManagement;
