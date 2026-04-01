import React, { useEffect, useMemo, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { fetchJson, formatDate, formatNumber } from './api';

export default function MatchList() {
  const [matches, setMatches] = useState([]);
  const [selectedMatchId, setSelectedMatchId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const data = await fetchJson('/api/matches');
        setMatches(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  const selectedMatch = useMemo(
    () => matches.find((match) => match.MatchID === selectedMatchId) || null,
    [matches, selectedMatchId]
  );

  const handleDelete = async () => {
    if (!selectedMatchId || !window.confirm('Delete this match?')) return;
    try {
      await fetchJson(`/api/matches/${selectedMatchId}`, { method: 'DELETE' });
      setMatches((current) => current.filter((match) => match.MatchID !== selectedMatchId));
      setSelectedMatchId(null);
    } catch (err) {
      setError(err.message);
    }
  };

  if (loading) return <div className="panel"><p>Loading matches...</p></div>;

  return (
    <section className="panel">
      <div className="section-header">
        <div>
          <h1>Matches</h1>
          <p className="subtitle">Backend match grid with match name, venue, and date in exact row format.</p>
        </div>
        {selectedMatch ? <div className="selection-chip">Selected: {selectedMatch.MatchName}</div> : null}
      </div>

      <div className="actions-panel">
        <Link to="/add-match"><button className="action-button add-button">Add Match</button></Link>
        <button type="button" className="action-button edit-button" disabled={!selectedMatchId} onClick={() => navigate(`/edit-match/${selectedMatchId}`)}>Edit Match</button>
        <button type="button" className="action-button history-button" disabled={!selectedMatchId} onClick={() => navigate(`/match-history/${selectedMatchId}`)}>Match History</button>
        <button type="button" className="action-button delete-button" disabled={!selectedMatchId} onClick={handleDelete}>Delete Match</button>
      </div>

      {error ? <div className="message error">{error}</div> : null}

      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Match Name</th>
              <th>Venue</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
            {matches.map((match) => (
              <tr
                key={match.MatchID}
                className={selectedMatchId === match.MatchID ? 'selected-row' : ''}
                onClick={() => setSelectedMatchId((current) => current === match.MatchID ? null : match.MatchID)}
              >
                <td>{formatNumber(match.MatchID)}</td>
                <td>{match.MatchName}</td>
                <td>{match.Venue}</td>
                <td>{formatDate(match.MatchDate)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}
