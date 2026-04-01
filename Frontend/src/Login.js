import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from './AuthContext';

export default function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    setIsSubmitting(true);
    try {
      await login(username, password);
      navigate('/');
    } catch (err) {
      setError(err.message);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="login-page">
      <div className="login-card">
        <div>
          <h1>Sports Analytics</h1>
          <p className="subtitle">Sign in to view players, teams, matches, awards, and history grids from the backend.</p>
        </div>
        <form onSubmit={handleSubmit} className="stack-form">
          <label htmlFor="username">Username</label>
          <input id="username" type="text" value={username} onChange={(e) => setUsername(e.target.value)} required />
          <label htmlFor="password">Password</label>
          <input id="password" type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
          {error ? <div className="message error">{error}</div> : null}
          <button type="submit" disabled={isSubmitting}>{isSubmitting ? 'Signing In...' : 'Log In'}</button>
        </form>
      </div>
    </div>
  );
}
