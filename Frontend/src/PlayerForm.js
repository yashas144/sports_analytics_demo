import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { fetchJson } from './api';

const initialState = {
  PlayerName: '',
  Age: '',
  DOB: '',
  Gender: 'Male',
  TotalGoalsScored: '',
};

export default function PlayerForm() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState(initialState);
  const [error, setError] = useState('');

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    try {
      await fetchJson('/api/addplayer', { method: 'POST', body: JSON.stringify(formData) });
      navigate('/players');
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <section className="panel form-panel">
      <h1>Add Player</h1>
      {error ? <div className="message error">{error}</div> : null}
      <form onSubmit={handleSubmit} className="stack-form two-col-form">
        <label>Player Name<input type="text" name="PlayerName" value={formData.PlayerName} onChange={handleChange} required /></label>
        <label>Age<input type="number" name="Age" value={formData.Age} onChange={handleChange} required /></label>
        <label>Date of Birth<input type="date" name="DOB" value={formData.DOB} onChange={handleChange} required /></label>
        <label>Gender
          <select name="Gender" value={formData.Gender} onChange={handleChange}>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
          </select>
        </label>
        <label>Total Goals Scored<input type="number" name="TotalGoalsScored" value={formData.TotalGoalsScored} onChange={handleChange} /></label>
        <button type="submit">Create Player</button>
      </form>
    </section>
  );
}
