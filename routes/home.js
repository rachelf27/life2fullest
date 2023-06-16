const express = require('express');
const router = express.Router();
const productDb = require('../db/productDb');

// GET /home page
router.get('/home', async (req, res) => {
  try {
    console.log("This is the home page")
  } catch (error) {
    res.status(500).json({ error: 'Failed to load home page' });
  }
});

module.exports = router;
