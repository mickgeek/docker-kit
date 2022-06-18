const http = require('http');

const hostname = '0.0.0.0';
const port = 8090;

const server = http.createServer((request, response) => {
  response.statusCode = 200;
  response.setHeader('Content-Type', 'text/plain; charset=UTF-8');
  response.end(JSON.stringify('It works! Your JavaScript application can grow up.' ));
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
