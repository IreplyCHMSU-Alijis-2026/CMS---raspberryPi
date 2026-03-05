const express = require("express");
const os = require("os");

const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
  res.send(`
    <html>
    <head>
      <meta http-equiv="refresh" content="10">
      <style>
        body {
          background: black;
          color: lime;
          font-family: monospace;
          text-align: center;
          padding-top: 20%;
        }
      </style>
    </head>
    <body>
      <h1>Digital Signage Test Mode</h1>
      <p>Hostname: ${os.hostname()}</p>
      <p>Time: ${new Date().toISOString()}</p>
    </body>
    </html>
  `);
});

app.listen(PORT, () => {
  console.log("Server running on http://localhost:3000");
});
