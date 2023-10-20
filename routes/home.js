// routes/home.js

const express = require("express");
const router = express.Router();

// GET /home page
router.get("/home", (req, res) => {
  try {
    res.json({ message });
  } catch (error) {
    res.status(500).json({ error: "Failed to load home page" });
  }
});

module.exports = router;
