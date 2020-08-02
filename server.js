'use strict';

const express = require('express');

// Constants
const host = '0.0.0.0';
const port = process.env.PORT || 7005;
// App
const app = express();
app.get('/', (req, res) => {
    res.send('Hello World');
});

app.listen(port, host);
console.log(`Running on http://${host}:${port}`);
