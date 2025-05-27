
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './TransactionForm.css';

const TransactionForm = ({ userId, transaction, onComplete }) => {
  const [type, setType] = useState(transaction?.type || 'income');
  const [category, setCategory] = useState(transaction?.category || '');
  const [amount, setAmount] = useState(transaction?.amount || '');

  const handleSubmit = (e) => {
    e.preventDefault();
    const payload = {
      user_id: userId,
      type,
      category,
      amount: parseFloat(amount)
    };

    const request = transaction
      ? axios.put(`http://localhost:8080/transactions/${transaction.id}`, payload)
      : axios.post("http://localhost:8080/transactions", payload);

    request
      .then(() => onComplete())
      .catch(err => alert("Failed to save transaction: " + err.message));
  };

   return (
    <div className="transaction-form-wrapper">
      <form className="transaction-form" onSubmit={handleSubmit}>
        <h3 className="form-title">{transaction ? "Edit" : "Add"} Transaction</h3>

        <label>
          Type:
          <select value={type} onChange={e => setType(e.target.value)} className="form-input">
            <option value="income">Income</option>
            <option value="expense">Expense</option>
          </select>
        </label>

        <label>
          Category:
          <input
            type="text"
            value={category}
            onChange={e => setCategory(e.target.value)}
            required
            className="form-input"
          />
        </label>

        <label>
          Amount:
          <input
            type="number"
            value={amount}
            onChange={e => setAmount(e.target.value)}
            step="0.01"
            required
            className="form-input"
          />
        </label>

        <div className="form-actions">
          <button className="submit-button" type="submit">
            {transaction ? "Update" : "Create"}
          </button>
          <button className="cancel-button" type="button" onClick={onComplete}>
            Cancel
          </button>
        </div>
      </form>
    </div>
  );
};

export default TransactionForm;