
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const UserForm = ({ user, onComplete }) => {
  const [name, setName] = useState(user?.name || "");
  const [email, setEmail] = useState(user?.email || "");

  const handleSubmit = (e) => {
    e.preventDefault();
    const payload = { name, email };
    const request = user
      ? axios.put(`http://localhost:8080/users/${user.id}`, payload)
      : axios.post("http://localhost:8080/users", payload);

    request
      .then(() => onComplete())
      .catch(err => alert("Failed to submit user: " + err.message));
  };

  return (
    <form onSubmit={handleSubmit}>
      <h3>{user ? "Edit User" : "Add New User"}</h3>
      <input
        placeholder="Name"
        value={name}
        onChange={e => setName(e.target.value)}
        required
      />
      <input
        placeholder="Email"
        value={email}
        onChange={e => setEmail(e.target.value)}
        required
      />
      <button type="submit">{user ? "Update" : "Create"}</button>
      <button type="button" onClick={onComplete}>Cancel</button>
    </form>
  );
};

export default UserForm;
