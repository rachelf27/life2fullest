// client/src/components/Navigation/Navigation.js

import React from "react";
import { Link } from "react-router-dom";

function Navigation() {
  return (
    <nav>
      <ul
        style={{
          listStyleType: "none",
          display: "flex",
          backgroundColor: "Blue",
          justifyContent: "space-around",
        }}
      >
        <li>
          <Link style={{ color: "white", textDecoration: "none" }} to="/home">
            Home
          </Link>
        </li>
        <li>
          <Link style={{ color: "white", textDecoration: "none" }} to="/shop">
            Shop
          </Link>
        </li>
        <li>
          <Link
            style={{ color: "white", textDecoration: "none" }}
            to="/contact"
          >
            Contact
          </Link>
        </li>
      </ul>
    </nav>
  );
}

export default Navigation;
