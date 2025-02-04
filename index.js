const http = require('http');
const fs = require('fs');
require('dotenv').config(); // Load environment variables from .env file

// Read the .env file content
let envContent = '';
try {
    envContent = fs.readFileSync('.env', 'utf8');
} catch (err) {
    console.error('Error reading .env file:', err);
    envContent = 'Could not read .env file.';
}

// Create the server
http.createServer(function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.write('Welcome to CloudPlexo.\n\n');
    res.write('Environment Variables:\n');
    res.write(envContent); // Display .env file content
    res.end();
}).listen(3000, () => console.log('Server running on port 3000'));
