const express = require('express');
const router = express.Router();
const productDb = require('../db/productDb');

// POST /api/admin/products - Add a new product
router.post('/products', async (req, res) => {
  try {
    const product = req.body;
    const result = await productDb.addProduct(product);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: 'Failed to add product' });
  }
});

// PUT /api/admin/products/:productId - Update a product
router.put('/products/:productId', async (req, res) => {
  try {
    const productId = req.params.productId;
    const update = req.body;
    const result = await productDb.updateProduct(productId, update);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update product' });
  }
});

// DELETE /api/admin/products/:productId - Delete a product
router.delete('/products/:productId', async (req, res) => {
  try {
    const productId = req.params.productId;
    const result = await productDb.deleteProduct(productId);
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete product' });
  }
});

module.exports = router;
