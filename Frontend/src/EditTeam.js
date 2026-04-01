import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { fetchJson } from './api';

export default function EditTeam() {
  const { teamId } = useParams();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    TeamName: '',
    Country: '',
    NumOfMatchesPlayed: 0,
    MatchesWon: 0,
    MatchesLost: 0,
    MatchesTie: 0,
    TotalGoalsScored: 0,
    ManagerID: '',
  });
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const [team, allUsers] = await Promise.all([
          fetchJson(`/api/teams/${teamId}`),
          fetchJson('/api/users'),
        ]);
        setFormData(team);
        setUsers(allUsers);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [teamId]);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    try {
      await fetchJson(`/api/teams/${teamId}`, { method: 'PUT', body: JSON.stringify(formData) });
      navigate('/teams');
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return <div className="panel"><p>Loading team...</p></div>;

  return (
    <section className="panel form-panel">
      <h1>Edit Team</h1>
      {error ? <div className="message error">{error}</div> : null}
      <form onSubmit={handleSubmit} className="stack-form two-col-form">
        <label>Team Name<input name="TeamName" value={formData.TeamName || ''} onChange={handleChange} required /></label>
        <label>Country<input name="Country" value={formData.Country || ''} onChange={handleChange} required /></label>
        <label>Matches Played<input type="number" name="NumOfMatchesPlayed" value={formData.NumOfMatchesPlayed || 0} onChange={handleChange} /></label>
        <label>Wins<input type="number" name="MatchesWon" value={formData.MatchesWon || 0} onChange={handleChange} /></label>
        <label>Losses<input type="number" name="MatchesLost" value={formData.MatchesLost || 0} onChange={handleChange} /></label>
        <label>Ties<input type="number" name="MatchesTie" value={formData.MatchesTie || 0} onChange={handleChange} /></label>
        <label>Total Goals<input type="number" name="TotalGoalsScored" value={formData.TotalGoalsScored || 0} onChange={handleChange} /></label>
        <label>Manager
          <select name="ManagerID" value={formData.ManagerID || ''} onChange={handleChange}>
            <option value="">Select Manager</option>
            {users.map((user) => (
              <option key={user.UserID} value={user.UserID}>{user.FullName || `${user.UserFirstName || ''} ${user.UserLastName || ''}`.trim() || user.UserName}</option>
            ))}
          </select>
        </label>
        <button type="submit">Update Team</button>
      </form>
    </section>
  );
}
