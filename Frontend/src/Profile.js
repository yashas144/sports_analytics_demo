import React, { useEffect, useState } from 'react';
import { useAuth } from './AuthContext';
import { fetchJson } from './api';

export default function Profile() {
  const { currentUser } = useAuth();
  const [profile, setProfile] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    async function load() {
      if (!currentUser?.UserID) return;
      try {
        const data = await fetchJson(`/api/users/${currentUser.UserID}`);
        setProfile(data);
      } catch (err) {
        setError(err.message);
      }
    }
    load();
  }, [currentUser]);

  if (error) return <div className="panel"><div className="message error">{error}</div></div>;
  if (!profile) return <div className="panel"><p>Loading profile...</p></div>;

  return (
    <section className="panel profile-grid">
      <div className="profile-card"><span>Full Name</span><strong>{profile.UserFirstName} {profile.UserLastName || ''}</strong></div>
      <div className="profile-card"><span>Username</span><strong>{profile.UserName}</strong></div>
      <div className="profile-card"><span>Role</span><strong>{profile.UserRole || '—'}</strong></div>
      <div className="profile-card"><span>Email</span><strong>{profile.Email || '—'}</strong></div>
      <div className="profile-card"><span>Mobile</span><strong>{profile.Mobile || '—'}</strong></div>
      <div className="profile-card"><span>User ID</span><strong>{profile.UserID}</strong></div>
    </section>
  );
}
