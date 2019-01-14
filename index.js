var http = require('http');

var server = http.createServer(function(request, response) {

    let nodeVersion = ' Yo que se';
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end("Hello World, Quino nodejs web sample app Develop branch has been merged.!" + " Nodejs version = " + nodeVersion);

});

var port = process.env.PORT || 1337;
server.listen(port);

console.log("Server running at http://localhost:%d", port);
