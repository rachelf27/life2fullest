import React from 'react';
import { Link } from 'react-router-dom';

function Navigation() {
return (
<nav>
<ul style={{ listStyleType: "none", display: "flex", backgroundColor: 'Blue', justifyContent: "space-around" }}>
<li><Link to="/">Home</Link></li>
<li><Link to="/shop">Shop</Link></li>
<li><Link to="/contact">Contact</Link></li>
</ul>
</nav>
);
}

export default Navigation;