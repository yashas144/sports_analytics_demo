import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { fetchJson } from './api';

export default function AddPlayerAward() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({ AwardName: '', PlayerID: '', TeamID: '', MatchID: '', DateofAward: '' });
  const [players, setPlayers] = useState([]);
  const [teams, setTeams] = useState([]);
  const [matches, setMatches] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      try {
        const [playerData, teamData, matchData] = await Promise.all([
          fetchJson('/api/players'),
          fetchJson('/api/teams'),
          fetchJson('/api/matches'),
        ]);
        setPlayers(playerData);
        setTeams(teamData);
        setMatches(matchData);
      } catch (err) {
        setError(err.message);
      }
    }
    load();
  }, []);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((current) => ({ ...current, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    try {
      await fetchJson('/api/player-awards', { method: 'POST', body: JSON.stringify(formData) });
      navigate('/player-awards');
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <section className="panel form-panel">
      <h1>Add Player Award</h1>
      {error ? <div className="message error">{error}</div> : null}
      <form onSubmit={handleSubmit} className="stack-form two-col-form">
        <label>Award Name<input name="AwardName" value={formData.AwardName} onChange={handleChange} required /></label>
        <label>Player
          <select name="PlayerID" value={formData.PlayerID} onChange={handleChange} required>
            <option value="">Select Player</option>
            {players.map((player) => <option key={player.PlayerID} value={player.PlayerID}>{player.PlayerName}</option>)}
          </select>
        </label>
        <label>Team
          <select name="TeamID" value={formData.TeamID} onChange={handleChange} required>
            <option value="">Select Team</option>
            {teams.map((team) => <option key={team.TeamID} value={team.TeamID}>{team.TeamName}</option>)}
          </select>
        </label>
        <label>Match
          <select name="MatchID" value={formData.MatchID} onChange={handleChange} required>
            <option value="">Select Match</option>
            {matches.map((match) => <option key={match.MatchID} value={match.MatchID}>{match.MatchName}</option>)}
          </select>
        </label>
        <label>Date of Award<input type="date" name="DateofAward" value={formData.DateofAward} onChange={handleChange} required /></label>
        <button type="submit">Create Award</button>
      </form>
    </section>
  );
}
