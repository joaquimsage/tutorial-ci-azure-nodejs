var http = require('http');

var server = http.createServer(function(request, response) {

    let nodeVersion = process.version;
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end("Hello World, Quino nodejs web sample app Develop branch has been merged. deployed 1.9.0-RC.0" + " Nodejs version = " + nodeVersion);

});

var port = process.env.PORT || 1337;
server.listen(port);

console.log("Server running at http://localhost:%d", port);
