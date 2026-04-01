import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { fetchJson } from './api';

export default function AddMatch() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({ MatchName: '', Venue: '', MatchDate: '' });
  const [error, setError] = useState('');

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    try {
      await fetchJson('/api/matches', { method: 'POST', body: JSON.stringify(formData) });
      navigate('/matches');
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <section className="panel form-panel">
      <h1>Add Match</h1>
      {error ? <div className="message error">{error}</div> : null}
      <form onSubmit={handleSubmit} className="stack-form">
        <label>Match Name<input name="MatchName" value={formData.MatchName} onChange={handleChange} required /></label>
        <label>Venue<input name="Venue" value={formData.Venue} onChange={handleChange} required /></label>
        <label>Match Date<input type="date" name="MatchDate" value={formData.MatchDate} onChange={handleChange} required /></label>
        <button type="submit">Create Match</button>
      </form>
    </section>
  );
}
