// client/src/components/Home/Home.js

import React, { useEffect, useState } from "react";

function Home() {
  const [message, setMessage] = useState("");

  useEffect(() => {
    fetch("/home")
      .then((response) => response.json())
      .then((data) => setMessage(data.message));
  }, []);

  return (
    <div>
      <h1>Welcome to Life2Fullest Store!</h1>
      <p>{message}</p>
      <p>
        Your one-stop shop for all exclusive products. Explore our collection
        today!
      </p>
    </div>
  );
}

export default Home;
