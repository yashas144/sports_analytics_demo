import React, { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { fetchJson, formatDate, formatNumber } from './api';

export default function PlayerHistory() {
  const { playerId } = useParams();
  const [player, setPlayer] = useState(null);
  const [history, setHistory] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const [playerData, historyData] = await Promise.all([
          fetchJson(`/api/players/${playerId}`),
          fetchJson(`/api/player-history/${playerId}`),
        ]);
        setPlayer(playerData);
        setHistory(historyData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [playerId]);

  if (loading) return <div className="panel"><p>Loading player history...</p></div>;

  return (
    <section className="panel">
      <div className="section-header">
        <div>
          <h1>Player History</h1>
          <p className="subtitle">{player ? player.PlayerName : 'Player'} match-by-match backend history grid.</p>
        </div>
        <Link to="/players" className="secondary-link">Back to Players</Link>
      </div>
      {error ? <div className="message error">{error}</div> : null}
      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>Date</th>
              <th>Team</th>
              <th>Played Against</th>
              <th>Result</th>
              <th>Goals Scored</th>
            </tr>
          </thead>
          <tbody>
            {history.length ? history.map((record, index) => (
              <tr key={`${record.MatchDate}-${index}`}>
                <td>{formatDate(record.MatchDate)}</td>
                <td>{record.TeamName || '—'}</td>
                <td>{record.PlayedAgainstName || record.PlayedAgainst || '—'}</td>
                <td>{record.MatchResult || '—'}</td>
                <td>{formatNumber(record.GoalsScored)}</td>
              </tr>
            )) : (
              <tr><td colSpan="5" className="empty-cell">No player history found.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </section>
  );
}
