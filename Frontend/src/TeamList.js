import React, { useEffect, useMemo, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { fetchJson, formatNumber } from './api';

export default function TeamList() {
  const [teams, setTeams] = useState([]);
  const [selectedTeamId, setSelectedTeamId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const data = await fetchJson('/api/teams');
        setTeams(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  const selectedTeam = useMemo(
    () => teams.find((team) => team.TeamID === selectedTeamId) || null,
    [teams, selectedTeamId]
  );

  const handleDelete = async () => {
    if (!selectedTeamId || !window.confirm('Delete this team?')) return;
    try {
      await fetchJson(`/api/teams/${selectedTeamId}`, { method: 'DELETE' });
      setTeams((current) => current.filter((team) => team.TeamID !== selectedTeamId));
      setSelectedTeamId(null);
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return <div className="panel"><p>Loading teams...</p></div>;

  return (
    <section className="panel">
      <div className="section-header">
        <div>
          <h1>Teams</h1>
          <p className="subtitle">Full team grid pulled from the backend, including manager and performance fields.</p>
        </div>
        {selectedTeam ? <div className="selection-chip">Selected: {selectedTeam.TeamName}</div> : null}
      </div>

      <div className="actions-panel">
        <Link to="/add-team"><button className="action-button add-button">Add Team</button></Link>
        <button type="button" className="action-button edit-button" disabled={!selectedTeamId} onClick={() => navigate(`/edit-team/${selectedTeamId}`)}>Edit Team</button>
        <button type="button" className="action-button history-button" disabled={!selectedTeamId} onClick={() => navigate(`/team-history/${selectedTeamId}`)}>Team History</button>
        <button type="button" className="action-button delete-button" disabled={!selectedTeamId} onClick={handleDelete}>Delete Team</button>
      </div>

      {error ? <div className="message error">{error}</div> : null}

      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Team Name</th>
              <th>Country</th>
              <th>Matches Played</th>
              <th>Wins</th>
              <th>Losses</th>
              <th>Ties</th>
              <th>Goals</th>
              <th>Manager</th>
            </tr>
          </thead>
          <tbody>
            {teams.map((team) => (
              <tr
                key={team.TeamID}
                className={selectedTeamId === team.TeamID ? 'selected-row' : ''}
                onClick={() => setSelectedTeamId((current) => current === team.TeamID ? null : team.TeamID)}
              >
                <td>{formatNumber(team.TeamID)}</td>
                <td>{team.TeamName}</td>
                <td>{team.Country}</td>
                <td>{formatNumber(team.NumOfMatchesPlayed)}</td>
                <td>{formatNumber(team.MatchesWon)}</td>
                <td>{formatNumber(team.MatchesLost)}</td>
                <td>{formatNumber(team.MatchesTie)}</td>
                <td>{formatNumber(team.TotalGoalsScored)}</td>
                <td>{team.ManagerName || '—'}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}
