import React, { useEffect, useState } from 'react';
import axios from 'axios';
import UserForm from './UserForm';
import UserTransactions from './UserTransactions';
import './Dashboard.css';

const Dashboard = () => {
  const [users, setUsers] = useState([]);
  const [editingUser, setEditingUser] = useState(null);
  const [showForm, setShowForm] = useState(false);
  const [selectedUserId, setSelectedUserId] = useState(null);

  const fetchUsers = () => {
    axios.get("http://localhost:8080/users")
      .then(res => setUsers(res.data))
      .catch(err => console.error("Failed to fetch users:", err));
  };

  useEffect(() => {
    if (selectedUserId === null) {
      fetchUsers();
    }
  }, [selectedUserId]);

  const handleEdit = (user) => {
    setEditingUser(user);
    setShowForm(true);
  };

  const handleDelete = (id) => {
    if (!window.confirm("Are you sure you want to delete this user?")) return;
    axios.delete(`http://localhost:8080/users/${id}`)
      .then(() => fetchUsers())
      .catch(err => alert("Failed to delete user: " + err.message));
  };

  const handleCreate = () => {
    setEditingUser(null);
    setShowForm(true);
  };

  const handleFormComplete = () => {
    setShowForm(false);
    fetchUsers();
  };

  if (selectedUserId) {
    return <UserTransactions userId={selectedUserId} onBack={() => setSelectedUserId(null)} />;
  }

  return (
    <div className="dashboard">
      <div className="dashboard-container">
        <h1 className="dashboard-title">Expense Dashboard</h1>
        {showForm ? (
          <UserForm user={editingUser} onComplete={handleFormComplete} />
        ) : (
          <>
            <button className="add-user-button" onClick={handleCreate}>➕ Add User</button>
            <table className="user-table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Total Income</th>
                  <th>Total Expense</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {users.map(user => (
                  <tr key={user.id}>
                    <td>
                      <button className="link-button" onClick={() => setSelectedUserId(user.id)}>
                        {user.name}
                      </button>
                    </td>
                    <td>${user.total_income}</td>
                    <td>${user.total_expense}</td>
                    <td>
                      <button className="edit-button" onClick={() => handleEdit(user)}>✏️ Edit</button>
                      <button className="delete-button" onClick={() => handleDelete(user.id)}>🗑️ Delete</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </>
        )}
      </div>
    </div>
  );
};

export default Dashboard;