// import dependencies
const express = require('express');
const router = express.Router();
const cors = require('cors');
const bodyParser = require('body-parser');
const {dirname} = require('path');
const { scanProducts } = require('./db/table');
const port = process.env.PORT || 8000;

// initialize express app
const app = express();

// configure middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(cors());


// define routes
app.get('/', (req, res) => {
    res.json({message: 'Welcome to Life2Fullest E-Commerce Platform'});
});

app.get('/api/test', (req, res) => {
    res.json({message: 'Test successful'});
});

app.get('/api/productListTest', async (req, res) => {
    try {
        // This is a dummy response to test if the endpoint works
        const products = [
          {id: 1, name: "Product 1", price: 100},
          {id: 2, name: "Product 2", price: 200},
        ];
        res.json(products);
      } catch(err) {
        res.status(500).json({ message: 'An error occurred' });
      }
  });
 
  app.get('/api/products', async (req, res) => {
    try {
      const allProducts = await scanProducts();
      res.json(allProducts);
    } catch(err) {
      res.status(500).json({ message: 'An error occurred' });
    }
  });

  //updateProduct
  /*
  await updateProduct(
    'product123', 
    'SET price = :newPrice, description = :newDescription', 
    {
        ':newPrice': 29.99,
        ':newDescription': 'This is an updated description'
    }
);*/

// start the server
app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});
