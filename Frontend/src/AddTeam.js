import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { fetchJson } from './api';

const initialState = {
  TeamName: '',
  Country: '',
  NumOfMatchesPlayed: 0,
  MatchesWon: 0,
  MatchesLost: 0,
  MatchesTie: 0,
  TotalGoalsScored: 0,
  ManagerID: '',
};

export default function AddTeam() {
  const [formData, setFormData] = useState(initialState);
  const [users, setUsers] = useState([]);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    fetchJson('/api/users').then(setUsers).catch((err) => setError(err.message));
  }, []);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    try {
      await fetchJson('/api/teams', { method: 'POST', body: JSON.stringify(formData) });
      navigate('/teams');
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <section className="panel form-panel">
      <h1>Add Team</h1>
      {error ? <div className="message error">{error}</div> : null}
      <form onSubmit={handleSubmit} className="stack-form two-col-form">
        <label>Team Name<input name="TeamName" value={formData.TeamName} onChange={handleChange} required /></label>
        <label>Country<input name="Country" value={formData.Country} onChange={handleChange} required /></label>
        <label>Matches Played<input type="number" name="NumOfMatchesPlayed" value={formData.NumOfMatchesPlayed} onChange={handleChange} /></label>
        <label>Wins<input type="number" name="MatchesWon" value={formData.MatchesWon} onChange={handleChange} /></label>
        <label>Losses<input type="number" name="MatchesLost" value={formData.MatchesLost} onChange={handleChange} /></label>
        <label>Ties<input type="number" name="MatchesTie" value={formData.MatchesTie} onChange={handleChange} /></label>
        <label>Total Goals<input type="number" name="TotalGoalsScored" value={formData.TotalGoalsScored} onChange={handleChange} /></label>
        <label>Manager
          <select name="ManagerID" value={formData.ManagerID} onChange={handleChange}>
            <option value="">Select Manager</option>
            {users.map((user) => (
              <option key={user.UserID} value={user.UserID}>{user.FullName || `${user.UserFirstName || ''} ${user.UserLastName || ''}`.trim() || user.UserName}</option>
            ))}
          </select>
        </label>
        <button type="submit">Create Team</button>
      </form>
    </section>
  );
}
