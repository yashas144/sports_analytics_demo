import React, { createContext, useContext, useMemo, useState } from 'react';
import { fetchJson } from './api';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [currentUser, setCurrentUser] = useState(() => {
    const saved = localStorage.getItem('sportsUser');
    return saved ? JSON.parse(saved) : null;
  });

  const login = async (username, password) => {
    const user = await fetchJson('/api/login', {
      method: 'POST',
      body: JSON.stringify({ username, password }),
    });
    localStorage.setItem('sportsUser', JSON.stringify(user));
    setCurrentUser(user);
    return user;
  };

  const logout = () => {
    localStorage.removeItem('sportsUser');
    setCurrentUser(null);
  };

  const value = useMemo(() => ({ currentUser, login, logout }), [currentUser]);
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  return useContext(AuthContext);
}
