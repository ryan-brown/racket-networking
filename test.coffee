http = require 'http'
port = 1337
x = 250
y = 250

http.createServer (req, res) ->
	value = ""

	unless req.url == "/favicon.ico"
		value = req.url[1..]
		switch value
			when "left" then x-=10
			when "right" then x+=10
			when "up" then y-=10
			when "down" then y+=10
			
	if x > 475 
		x = 475
		console.log "Right wall collision"
	else if x < 25
		x = 25
		console.log "Left wall collision"
	if y > 475
		y = 475
		console.log "Bottom wall collision"
	else if y < 25
		y = 25
		console.log "Top wall collision"

	console.log value if value != ""		
	res.writeHead 200, {"content-type" : "text/plain"}
	res.end "#{x}&#{y}"
.listen port

console.log "Server has begun on port #{port}"