import React, { useEffect, useMemo, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { fetchJson, formatDate, formatNumber } from './api';

export default function PlayerList() {
  const [players, setPlayers] = useState([]);
  const [selectedPlayerId, setSelectedPlayerId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const data = await fetchJson('/api/players');
        setPlayers(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  const selectedPlayer = useMemo(
    () => players.find((player) => player.PlayerID === selectedPlayerId) || null,
    [players, selectedPlayerId]
  );

  const handleDelete = async () => {
    if (!selectedPlayerId || !window.confirm('Delete this player?')) return;
    try {
      await fetchJson(`/api/players/${selectedPlayerId}`, { method: 'DELETE' });
      setPlayers((current) => current.filter((player) => player.PlayerID !== selectedPlayerId));
      setSelectedPlayerId(null);
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return <div className="panel"><p>Loading players...</p></div>;

  return (
    <div className="page-stack">
      <section className="panel">
        <div className="section-header">
          <div>
            <h1>Players</h1>
            <p className="subtitle">Exact backend player grid with selection, actions, and full row visibility.</p>
          </div>
          {selectedPlayer ? <div className="selection-chip">Selected: {selectedPlayer.PlayerName}</div> : null}
        </div>

        <div className="actions-panel">
          <Link to="/add-player"><button className="action-button add-button">Add Player</button></Link>
          <button type="button" className="action-button edit-button" disabled={!selectedPlayerId} onClick={() => navigate(`/edit-player/${selectedPlayerId}`)}>Edit Player</button>
          <button type="button" className="action-button history-button" disabled={!selectedPlayerId} onClick={() => navigate(`/player-history/${selectedPlayerId}`)}>Player History</button>
          <button type="button" className="action-button dashboard-button" disabled={!selectedPlayerId} onClick={() => navigate(`/player-dashboard/${selectedPlayerId}`)}>Dashboard</button>
          <button type="button" className="action-button delete-button" disabled={!selectedPlayerId} onClick={handleDelete}>Delete Player</button>
        </div>

        {error ? <div className="message error">{error}</div> : null}

        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Player Name</th>
                <th>Age</th>
                <th>Date of Birth</th>
                <th>Gender</th>
                <th>Total Goals</th>
              </tr>
            </thead>
            <tbody>
              {players.map((player) => (
                <tr
                  key={player.PlayerID}
                  className={selectedPlayerId === player.PlayerID ? 'selected-row' : ''}
                  onClick={() => setSelectedPlayerId((current) => current === player.PlayerID ? null : player.PlayerID)}
                >
                  <td>{formatNumber(player.PlayerID)}</td>
                  <td>{player.PlayerName}</td>
                  <td>{formatNumber(player.Age)}</td>
                  <td>{formatDate(player.DOB)}</td>
                  <td>{player.Gender || '—'}</td>
                  <td>{formatNumber(player.TotalGoalsScored)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </div>
  );
}
