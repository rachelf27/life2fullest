// client/src/components/Contact/Contact.js

// This is a mocked form and does not send emails because it is not configured to do so

import React from "react";

function Contact() {
  return (
    <div>
      <h1>Contact Us</h1>
      <p>Have questions? Reach out to us!</p>
      <form action="#" method="post">
        <div>
          <label htmlFor="name">Name:</label>
          <input type="text" id="name" name="name" required />
        </div>
        <div>
          <label htmlFor="email">Email:</label>
          <input type="email" id="email" name="email" required />
        </div>
        <div>
          <label htmlFor="message">Message:</label>
          <textarea id="message" name="message" rows="4" required></textarea>
        </div>
        <div>
          <button type="submit">Send</button>
        </div>
      </form>
    </div>
  );
}

export default Contact;
