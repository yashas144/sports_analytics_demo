import React, { useEffect, useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { fetchJson, formatDate, formatNumber } from './api';

export default function PlayerDashboard() {
  const { playerId } = useParams();
  const [player, setPlayer] = useState(null);
  const [history, setHistory] = useState([]);
  const [awards, setAwards] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const [playerData, historyData, awardsData] = await Promise.all([
          fetchJson(`/api/players/${playerId}`),
          fetchJson(`/api/player-history/${playerId}`),
          fetchJson(`/api/player-awards-summary/${playerId}`),
        ]);
        setPlayer(playerData);
        setHistory(historyData);
        setAwards(awardsData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, [playerId]);

  const summary = useMemo(() => {
    const wins = history.filter((game) => String(game.MatchResult || '').toLowerCase().includes('win')).length;
    const losses = history.filter((game) => String(game.MatchResult || '').toLowerCase().includes('loss')).length;
    const draws = history.length - wins - losses;
    const goals = history.reduce((sum, game) => sum + Number(game.GoalsScored || 0), 0);
    return { wins, losses, draws, goals };
  }, [history]);

  if (loading) return <div className="panel"><p>Loading player dashboard...</p></div>;

  return (
    <div className="page-stack">
      <section className="panel">
        <div className="section-header">
          <div>
            <h1>{player ? player.PlayerName : 'Player Dashboard'}</h1>
            <p className="subtitle">Detailed backend-driven dashboard with summary cards and exact tables.</p>
          </div>
          <Link to="/players" className="secondary-link">Back to Players</Link>
        </div>
        {error ? <div className="message error">{error}</div> : null}
        <div className="stats-grid compact">
          <div className="stat-card"><span>Total History Rows</span><strong>{formatNumber(history.length)}</strong></div>
          <div className="stat-card"><span>Total Goals</span><strong>{formatNumber(summary.goals)}</strong></div>
          <div className="stat-card"><span>Wins / Draws / Losses</span><strong>{`${summary.wins} / ${summary.draws} / ${summary.losses}`}</strong></div>
          <div className="stat-card"><span>Total Awards</span><strong>{formatNumber(awards.length)}</strong></div>
        </div>
      </section>

      <section className="dashboard-two-col">
        <div className="panel">
          <div className="section-header"><h2>Recent Match History</h2></div>
          <div className="table-container fixed-height">
            <table>
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Team</th>
                  <th>Opponent</th>
                  <th>Result</th>
                  <th>Goals</th>
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
                )) : <tr><td colSpan="5" className="empty-cell">No history found.</td></tr>}
              </tbody>
            </table>
          </div>
        </div>

        <div className="panel">
          <div className="section-header"><h2>Awards</h2></div>
          <div className="table-container fixed-height">
            <table>
              <thead>
                <tr>
                  <th>Award</th>
                  <th>Date</th>
                  <th>Match</th>
                </tr>
              </thead>
              <tbody>
                {awards.length ? awards.map((award, index) => (
                  <tr key={`${award.AwardName}-${index}`}>
                    <td>{award.AwardName}</td>
                    <td>{formatDate(award.DateofAward)}</td>
                    <td>{award.MatchName || '—'}</td>
                  </tr>
                )) : <tr><td colSpan="3" className="empty-cell">No awards found.</td></tr>}
              </tbody>
            </table>
          </div>
        </div>
      </section>
    </div>
  );
}
