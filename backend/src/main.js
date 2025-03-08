const express = require('express');
const morgan = require('morgan');
const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(morgan('dev'));

// Routes
app.get('/', (req, res) => {
  res.send('Hello, KRYPTON!');
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

app.listen(port, () => {
  console.log(`Backend server is running at http://localhost:${port}`);
});
