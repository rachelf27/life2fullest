import React, { useEffect, useState } from 'react';

function Home() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('/home')
      .then(response => response.json())
      .then(data => setMessage(data.message));
  }, []); // Empty array means this effect runs once when component mounts

  return (
    <div>
      <h1>Welcome to our store!</h1>
      <p>{message}</p>
    </div>
  );
}

export default Home;