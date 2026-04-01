import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { fetchJson } from './api';

export default function EditMatch() {
  const { matchId } = useParams();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({ MatchName: '', Venue: '', MatchDate: '' });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const data = await fetchJson(`/api/matches/${matchId}`);
        setFormData(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [matchId]);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    try {
      await fetchJson(`/api/matches/${matchId}`, { method: 'PUT', body: JSON.stringify(formData) });
      navigate('/matches');
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return <div className="panel"><p>Loading match...</p></div>;

  return (
    <section className="panel form-panel">
      <h1>Edit Match</h1>
      {error ? <div className="message error">{error}</div> : null}
      <form onSubmit={handleSubmit} className="stack-form">
        <label>Match Name<input name="MatchName" value={formData.MatchName || ''} onChange={handleChange} required /></label>
        <label>Venue<input name="Venue" value={formData.Venue || ''} onChange={handleChange} required /></label>
        <label>Match Date<input type="date" name="MatchDate" value={formData.MatchDate || ''} onChange={handleChange} required /></label>
        <button type="submit">Update Match</button>
      </form>
    </section>
  );
}
