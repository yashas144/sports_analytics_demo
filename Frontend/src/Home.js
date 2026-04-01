import React, { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { fetchJson, formatDate, formatNumber } from './api';

export default function Home() {
  const [players, setPlayers] = useState([]);
  const [teams, setTeams] = useState([]);
  const [matches, setMatches] = useState([]);
  const [awards, setAwards] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      setLoading(true);
      setError('');
      try {
        const [playersData, teamsData, matchesData, awardsData] = await Promise.all([
          fetchJson('/api/players'),
          fetchJson('/api/teams'),
          fetchJson('/api/matches'),
          fetchJson('/api/player-awards'),
        ]);
        setPlayers(playersData);
        setTeams(teamsData);
        setMatches(matchesData);
        setAwards(awardsData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }
    load();
  }, []);

  const topPlayers = useMemo(
    () => [...players].sort((a, b) => (b.TotalGoalsScored || 0) - (a.TotalGoalsScored || 0)).slice(0, 5),
    [players]
  );

  const topTeams = useMemo(
    () => [...teams].sort((a, b) => (b.MatchesWon || 0) - (a.MatchesWon || 0)).slice(0, 5),
    [teams]
  );

  if (loading) return <div className="panel"><p>Loading dashboard...</p></div>;
  if (error) return <div className="panel"><div className="message error">{error}</div></div>;

  return (
    <div className="page-stack">
      <section className="hero panel">
        <div>
          <h1 className="main-title">Sports Analytics Dashboard</h1>
          <p className="subtitle">Browse exact backend results in structured grids for players, teams, matches, awards, and detailed history views.</p>
        </div>
        <div className="hero-actions">
          <Link to="/players" className="primary-link">Open Player Grid</Link>
          <Link to="/teams" className="secondary-link">Open Team Grid</Link>
        </div>
      </section>

      <section className="stats-grid">
        <div className="stat-card"><span>Total Players</span><strong>{formatNumber(players.length)}</strong></div>
        <div className="stat-card"><span>Total Teams</span><strong>{formatNumber(teams.length)}</strong></div>
        <div className="stat-card"><span>Total Matches</span><strong>{formatNumber(matches.length)}</strong></div>
        <div className="stat-card"><span>Total Player Awards</span><strong>{formatNumber(awards.length)}</strong></div>
      </section>

      <section className="dashboard-two-col">
        <div className="panel">
          <div className="section-header">
            <h2>Top Players by Goals</h2>
            <Link to="/players">View all</Link>
          </div>
          <div className="table-container">
            <table>
              <thead>
                <tr>
                  <th>Player</th>
                  <th>Age</th>
                  <th>Goals</th>
                  <th>Date of Birth</th>
                </tr>
              </thead>
              <tbody>
                {topPlayers.map((player) => (
                  <tr key={player.PlayerID}>
                    <td>{player.PlayerName}</td>
                    <td>{formatNumber(player.Age)}</td>
                    <td>{formatNumber(player.TotalGoalsScored)}</td>
                    <td>{formatDate(player.DOB)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        <div className="panel">
          <div className="section-header">
            <h2>Top Teams by Wins</h2>
            <Link to="/teams">View all</Link>
          </div>
          <div className="table-container">
            <table>
              <thead>
                <tr>
                  <th>Team</th>
                  <th>Country</th>
                  <th>Wins</th>
                  <th>Matches</th>
                </tr>
              </thead>
              <tbody>
                {topTeams.map((team) => (
                  <tr key={team.TeamID}>
                    <td>{team.TeamName}</td>
                    <td>{team.Country}</td>
                    <td>{formatNumber(team.MatchesWon)}</td>
                    <td>{formatNumber(team.NumOfMatchesPlayed)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </section>
    </div>
  );
}
