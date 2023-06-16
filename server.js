// Import dependencies
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const {dirname} = require('path');
const adminRoutes = require('./routes/admin');
const publicRoutes = require('./routes/public')

const port = process.env.PORT || 8000;

// Initialize express app
const app = express();

// Configure middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(cors());

// Define routes

// Admin routes
app.use('/admin', adminRoutes);

// Public routes
app.use('/home', publicRoutes);
app.use('/api/products', publicRoutes);


// This is a test route
app.get('/test', (req, res) => {
    res.json({message: 'Welcome to Life2Fullest E-Commerce Platform'});
});

// start the server
app.listen(port, () => {
    console.log(`Server started on port ${port}`);
});
