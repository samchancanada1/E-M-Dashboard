
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './UserForm.css';

const UserForm = ({ user, onComplete }) => {
  const [name, setName] = useState(user?.name || "");
  const [email, setEmail] = useState(user?.email || "");
  const [emailError, setEmailError] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!email || emailError) {
      alert('Please correct the email before submitting');
      return;
    }
    const payload = { name, email };
    const request = user
      ? axios.put(`http://localhost:8080/users/${user.id}`, payload)
      : axios.post("http://localhost:8080/users", payload);

    request
      .then(() => onComplete())
      .catch(err => alert("Failed to submit user: " + err.message));
  };

  return (
    <form className="user-form" onSubmit={handleSubmit}>
      <h3 className="form-title">{user ? "Edit User" : "Add New User"}</h3>

      <label>
        Name
        <input
          className="form-input"
          type="text"
          placeholder="Enter name"
          value={name}
          onChange={e => setName(e.target.value)}
          required
        />
      </label>

      <label>
        Email
        <input
          className="form-input"
          type="email"
          placeholder="Enter email"
          value={email}
          onChange={e => {
            const value = e.target.value;
            setEmail(value);
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
              setEmailError('Please enter a valid email address');
            } else {
              setEmailError('');
            }
          }}
          required
        />
      </label>

      {emailError && <p className="error-text">{emailError}</p>}

      <div className="form-actions">
        <button className="submit-button" type="submit">
          {user ? "Update" : "Create"}
        </button>
        <button className="cancel-button" type="button" onClick={onComplete}>
          Cancel
        </button>
      </div>
    </form>
  );
};

export default UserForm;