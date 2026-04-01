import React, { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { fetchJson } from './api';

export default function MatchHistory() {
  const { matchId } = useParams();
  const [match, setMatch] = useState(null);
  const [history, setHistory] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const [matchData, historyData] = await Promise.all([
          fetchJson(`/api/matches/${matchId}`),
          fetchJson(`/api/match-history/${matchId}`),
        ]);
        setMatch(matchData);
        setHistory(historyData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [matchId]);

  if (loading) return <div className="panel"><p>Loading match history...</p></div>;

  return (
    <section className="panel">
      <div className="section-header">
        <div>
          <h1>Match History</h1>
          <p className="subtitle">{match ? match.MatchName : 'Match'} exact result rows from the backend.</p>
        </div>
        <Link to="/matches" className="secondary-link">Back to Matches</Link>
      </div>
      {error ? <div className="message error">{error}</div> : null}
      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>Team</th>
              <th>Played Against</th>
              <th>Final Result</th>
            </tr>
          </thead>
          <tbody>
            {history.length ? history.map((record, index) => (
              <tr key={`${record.TeamName}-${index}`}>
                <td>{record.TeamName || '—'}</td>
                <td>{record.PlayedAgainstName || record.PlayedAgainst || '—'}</td>
                <td>{record.MatchResult || '—'}</td>
              </tr>
            )) : (
              <tr><td colSpan="3" className="empty-cell">No match history found.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </section>
  );
}
