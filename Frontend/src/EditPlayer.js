import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { fetchJson } from './api';

export default function EditPlayer() {
  const { playerId } = useParams();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    PlayerName: '',
    Age: '',
    DOB: '',
    Gender: 'Male',
    TotalGoalsScored: '',
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const data = await fetchJson(`/api/players/${playerId}`);
        setFormData({ ...data, DOB: data.DOB ? String(data.DOB).slice(0, 10) : '' });
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [playerId]);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    try {
      await fetchJson(`/api/players/${playerId}`, { method: 'PUT', body: JSON.stringify(formData) });
      navigate('/players');
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return <div className="panel"><p>Loading player...</p></div>;

  return (
    <section className="panel form-panel">
      <h1>Edit Player</h1>
      {error ? <div className="message error">{error}</div> : null}
      <form onSubmit={handleSubmit} className="stack-form two-col-form">
        <label>Player Name<input type="text" name="PlayerName" value={formData.PlayerName || ''} onChange={handleChange} required /></label>
        <label>Age<input type="number" name="Age" value={formData.Age || ''} onChange={handleChange} required /></label>
        <label>Date of Birth<input type="date" name="DOB" value={formData.DOB || ''} onChange={handleChange} required /></label>
        <label>Gender
          <select name="Gender" value={formData.Gender || 'Male'} onChange={handleChange}>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
          </select>
        </label>
        <label>Total Goals Scored<input type="number" name="TotalGoalsScored" value={formData.TotalGoalsScored || ''} onChange={handleChange} /></label>
        <button type="submit">Update Player</button>
      </form>
    </section>
  );
}
