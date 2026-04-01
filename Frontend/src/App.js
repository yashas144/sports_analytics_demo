import React, { useState } from 'react';
import { BrowserRouter, Routes, Route, Link, Outlet } from 'react-router-dom';
import { useAuth } from './AuthContext';
import Login from './Login';
import ProtectedRoute from './ProtectedRoute';
import Home from './Home';
import PlayerList from './PlayerList';
import TeamList from './TeamList';
import MatchList from './MatchList';
import PlayerAwardList from './PlayerAwardList';
import Profile from './Profile';
import PlayerForm from './PlayerForm';
import EditPlayer from './EditPlayer';
import AddTeam from './AddTeam';
import EditTeam from './EditTeam';
import AddMatch from './AddMatch';
import EditMatch from './EditMatch';
import AddPlayerAward from './AddPlayerAward';
import PlayerHistory from './PlayerHistory';
import TeamHistory from './TeamHistory';
import MatchHistory from './MatchHistory';
import PlayerDashboard from './PlayerDashboard';
import './App.css';

function MainLayout() {
  const { currentUser, logout } = useAuth();
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <div className="app-shell">
      <header className="navbar">
        <Link to="/" className="nav-link brand">Sports Analytics</Link>
        <nav className="nav-items">
          <Link to="/players" className="nav-link">Players</Link>
          <Link to="/teams" className="nav-link">Teams</Link>
          <Link to="/matches" className="nav-link">Matches</Link>
          <Link to="/player-awards" className="nav-link">Player Awards</Link>
        </nav>
        <div className="user-menu">
          <button onClick={() => setMenuOpen((open) => !open)} className="user-menu-button" type="button">
            {currentUser ? `${currentUser.UserFirstName} ${currentUser.UserLastName || ''}`.trim() : 'Account'}
          </button>
          {menuOpen && (
            <div className="dropdown-menu">
              <Link to="/profile" onClick={() => setMenuOpen(false)}>Profile</Link>
              <button type="button" onClick={logout}>Log Out</button>
            </div>
          )}
        </div>
      </header>
      <main className="page-frame">
        <Outlet />
      </main>
    </div>
  );
}

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/" element={<ProtectedRoute><MainLayout /></ProtectedRoute>}>
          <Route index element={<Home />} />
          <Route path="players" element={<PlayerList />} />
          <Route path="teams" element={<TeamList />} />
          <Route path="matches" element={<MatchList />} />
          <Route path="player-awards" element={<PlayerAwardList />} />
          <Route path="profile" element={<Profile />} />
          <Route path="add-player" element={<PlayerForm />} />
          <Route path="edit-player/:playerId" element={<EditPlayer />} />
          <Route path="player-history/:playerId" element={<PlayerHistory />} />
          <Route path="player-dashboard/:playerId" element={<PlayerDashboard />} />
          <Route path="add-team" element={<AddTeam />} />
          <Route path="edit-team/:teamId" element={<EditTeam />} />
          <Route path="team-history/:teamId" element={<TeamHistory />} />
          <Route path="add-match" element={<AddMatch />} />
          <Route path="edit-match/:matchId" element={<EditMatch />} />
          <Route path="match-history/:matchId" element={<MatchHistory />} />
          <Route path="add-player-award" element={<AddPlayerAward />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
