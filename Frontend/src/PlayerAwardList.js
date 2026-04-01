import React, { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { fetchJson, formatDate } from './api';

export default function PlayerAwardList() {
  const [awards, setAwards] = useState([]);
  const [selectedAwardId, setSelectedAwardId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const data = await fetchJson('/api/player-awards');
        setAwards(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  const selectedAward = useMemo(
    () => awards.find((award) => award.ID === selectedAwardId) || null,
    [awards, selectedAwardId]
  );

  const handleDelete = async () => {
    if (!selectedAwardId || !window.confirm('Delete this award?')) return;
    try {
      await fetchJson(`/api/player-awards/${selectedAwardId}`, { method: 'DELETE' });
      setAwards((current) => current.filter((award) => award.ID !== selectedAwardId));
      setSelectedAwardId(null);
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return <div className="panel"><p>Loading awards...</p></div>;

  return (
    <section className="panel">
      <div className="section-header">
        <div>
          <h1>Player Awards</h1>
          <p className="subtitle">Exact award result grid with player, team, match, and award date columns.</p>
        </div>
        {selectedAward ? <div className="selection-chip">Selected: {selectedAward.AwardName}</div> : null}
      </div>

      <div className="actions-panel">
        <Link to="/add-player-award"><button className="action-button add-button">Add Award</button></Link>
        <button type="button" className="action-button delete-button" disabled={!selectedAwardId} onClick={handleDelete}>Delete Award</button>
      </div>

      {error ? <div className="message error">{error}</div> : null}

      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Award Name</th>
              <th>Player</th>
              <th>Team</th>
              <th>Match</th>
              <th>Date of Award</th>
            </tr>
          </thead>
          <tbody>
            {awards.map((award) => (
              <tr
                key={award.ID}
                className={selectedAwardId === award.ID ? 'selected-row' : ''}
                onClick={() => setSelectedAwardId((current) => current === award.ID ? null : award.ID)}
              >
                <td>{award.ID}</td>
                <td>{award.AwardName}</td>
                <td>{award.PlayerName || '—'}</td>
                <td>{award.TeamName || '—'}</td>
                <td>{award.MatchName || '—'}</td>
                <td>{formatDate(award.DateofAward)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}
