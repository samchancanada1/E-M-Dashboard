
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import TransactionForm from './TransactionForm';
import './UserTransactions.css';


const UserTransactions = ({ userId, onBack }) => {
  const [transactions, setTransactions] = useState([]);
  const [editingTransaction, setEditingTransaction] = useState(null);
  const [showForm, setShowForm] = useState(false);

  const fetchTransactions = () => {
    axios.get(`http://localhost:8080/users/${userId}/transactions`)
      .then(res => setTransactions(res.data))
      .catch(err => console.error("Failed to fetch transactions:", err));
  };

  useEffect(() => {
    fetchTransactions();
  }, [userId]);

  const handleEdit = (tx) => {
    setEditingTransaction(tx);
    setShowForm(true);
  };

  const handleDelete = (id) => {
    if (!window.confirm("Delete this transaction?")) return;
    axios.delete(`http://localhost:8080/transactions/${id}`)
      .then(fetchTransactions)
      .catch(err => alert("Delete failed: " + err.message));
  };

  const handleAdd = () => {
    setEditingTransaction(null);
    setShowForm(true);
  };

  const handleFormComplete = () => {
    setShowForm(false);
    fetchTransactions();
  };

  return (
    <div className="transactions-page">
      <div className="transactions-container">


        {showForm ? (
          <TransactionForm
            userId={userId}
            transaction={editingTransaction}
            onComplete={handleFormComplete}
          />
        ) : (
          <>
            <div className="transactions-header">
              <h2>User Transactions</h2>
              <div>
                <button className="back-button" onClick={onBack}>← Back</button>
                {!showForm && (
                  <button className="add-button" onClick={handleAdd}>➕ Add Transaction</button>
                )}
              </div>
            </div>
            <table className="transactions-table">
              <thead>
                <tr>
                  <th>Type</th>
                  <th>Category</th>
                  <th>Amount</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {transactions.map(tx => (
                  <tr key={tx.id}>
                    <td>{tx.type}</td>
                    <td>{tx.category}</td>
                    <td>${tx.amount}</td>
                    <td>
                      <button className="edit-button" onClick={() => handleEdit(tx)}>✏️</button>
                      <button className="delete-button" onClick={() => handleDelete(tx.id)}>🗑️</button>
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

export default UserTransactions;