import React, { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { fetchJson, formatDate, formatNumber } from './api';

export default function TeamHistory() {
  const { teamId } = useParams();
  const [team, setTeam] = useState(null);
  const [history, setHistory] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const [teamData, historyData] = await Promise.all([
          fetchJson(`/api/teams/${teamId}`),
          fetchJson(`/api/team-history/${teamId}`),
        ]);
        setTeam(teamData);
        setHistory(historyData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [teamId]);

  if (loading) return <div className="panel"><p>Loading team history...</p></div>;

  return (
    <section className="panel">
      <div className="section-header">
        <div>
          <h1>Team History</h1>
          <p className="subtitle">{team ? team.TeamName : 'Team'} historical result grid from the backend.</p>
        </div>
        <Link to="/teams" className="secondary-link">Back to Teams</Link>
      </div>
      {error ? <div className="message error">{error}</div> : null}
      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>Date</th>
              <th>Played Against</th>
              <th>Result</th>
              <th>Goals Scored</th>
            </tr>
          </thead>
          <tbody>
            {history.length ? history.map((record, index) => (
              <tr key={`${record.MatchDate}-${index}`}>
                <td>{formatDate(record.MatchDate)}</td>
                <td>{record.PlayedAgainstName || record.PlayedAgainst || '—'}</td>
                <td>{record.MatchResult || '—'}</td>
                <td>{formatNumber(record.GoalsScored)}</td>
              </tr>
            )) : (
              <tr><td colSpan="4" className="empty-cell">No team history found.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </section>
  );
}
