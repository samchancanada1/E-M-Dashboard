import React, { useEffect, useState } from 'react';
import axios from 'axios';
import UserForm from './UserForm';
import UserTransactions from './UserTransactions';

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
    <div style={{ padding: '20px' }}>
      <h1>Expense Dashboard</h1>
      {showForm ? (
        <UserForm user={editingUser} onComplete={handleFormComplete} />
      ) : (
        <>
          <button onClick={handleCreate}>➕ Add User</button>
          <table border="1" cellPadding="10" style={{ marginTop: '20px' }}>
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
                    <button onClick={() => setSelectedUserId(user.id)} style={{ all: 'unset', cursor: 'pointer', color: 'blue' }}>
                      {user.name}
                    </button>
                  </td>
                  <td>${user.total_income}</td>
                  <td>${user.total_expense}</td>
                  <td>
                    <button onClick={() => handleEdit(user)}>✏️ Edit</button>
                    <button onClick={() => handleDelete(user.id)}>🗑️ Delete</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </>
      )}
    </div>
  );
};

export default Dashboard;
