# Use HAPI to make the markov generator available through HTTP
server = new (require 'hapi').Server()
generator = require './markov'

server.connection 
	port: 4000
	host: 'localhost'

server.route [
	{
		method: 'GET'
		path: '/'
		handler: (req, reply) ->
			if req.query.callback?
				reply "#{req.query.callback}({\"name\":\"#{generator.randomMarkov(1,3)}\"})"
			else
				reply generator.randomMarkov(1,3)
	}
]

server.start () ->
	console.log "Running!"