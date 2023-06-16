const express = require('express');
const router = express.Router();
const productDb = require('../db/productDb');

// GET /home page
router.get('/home', async (req, res) => {
  try {
    // const products = await productDb.scanProducts;
    // res.json(products);
  } catch (error) {
    res.status(500).json({ error: 'Failed to load home page' });
  }
});

// GET /api/products - Get all products
router.get('/api/products', async (req, res) => {
  try {
    const products = await productDb.scanProducts;
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: 'Failed to get products' });
  }
});

module.exports = router;
