import React, { useEffect, useState } from 'react';
import ProductList from '../ProductList/ProductList'; // adjust the import path as necessary

function Home() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('/api/test')
      .then(response => response.json())
      .then(data => setMessage(data.message));
  }, []); // Empty array means this effect runs once when component mounts

  return (
    <div>
      <h1>Welcome to our store!</h1>
      <p>{message}</p>
      <ProductList />
    </div>
  );
}

export default Home;