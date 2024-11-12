const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World: Version 2!');
});

app.listen(port, () => {
  console.log(`HI! App listening at http://localhost:${port}`);
});