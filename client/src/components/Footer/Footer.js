// client/src/components/Footer/Footer.js

import React from "react";

const Footer = () => (
  <footer
    style={{
      backgroundColor: "grey",
      color: "white",
      padding: "10px",
      textAlign: "center",
    }}
  >
    © {new Date().getFullYear()} Life2Fullest E-Commerce. All rights reserved.
  </footer>
);

export default Footer;
