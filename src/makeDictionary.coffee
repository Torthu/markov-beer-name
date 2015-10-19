# Generate dictionary
mbit = (require 'microbrewit-node').init()
_ = require 'lodash'
fs = require 'fs'

isASCII = (str) ->
    return /^[\x00-\x7F]*$/.test(str)

dictionary = []
getBeers = (skip=0) ->
	mbit.beers.get { size: 1000, from: skip }, (err, res, body) ->
		for beer in body.beers
			beerName = beer.name.toLowerCase().replace(/[^a-z]/gmi, " ").replace(/\s+/g, " ")
			if isASCII(beerName)

				dict = beerName.split(' ')

				if dict.length > 1
					dictionary = dictionary.concat dict
				else 
					dictionary.push beerName 

		if skip < 250000
			console.log "Iteration #{skip/1000}"
			getBeers(skip+1000)
		else			
			dictionary = _.uniq dictionary
			fs.writeFileSync('./dictionary.json', JSON.stringify dictionary)

getBeers()