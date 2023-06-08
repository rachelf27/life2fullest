import React from 'react';
import { render } from 'react-dom';
import './index.css';
import App from './App';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import HelloWorld from './components/HelloWorld/HelloWorld';
import Home from './components/Home/Home';
import Shop from './components/Shop/Shop';
import Contact from './components/Contact/Contact';
import Navigation from './components/Navigation/Navigation';

render(
  <Router>
    <Navigation />
    <App>
      <Routes>
        <Route path="/" element={<Home />}/>
        <Route path="/helloworld" element={<HelloWorld />}/>
        <Route path="/shop" element={<Shop />}/>
        <Route path="/contact" element={<Contact />}/>
        </Routes>
    </App>
  </Router> , document.getElementById('root'));