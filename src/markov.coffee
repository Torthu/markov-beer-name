Foswig = require 'foswig'
fs = require 'fs'

chain = new Foswig(4) # Read Foswig.js documentation

try
	chain.addWordsToChain JSON.parse fs.readFileSync('./dictionary.json')
catch e 
	console.error 'Could not read dictionary.'

# Generate a name
# @param [Int] min (default: 5) Minimum number of characters
# @param [Int] max (default: 10) Maximum number of characters
# @param [Bool] unique (default: false) Don't return words from dictionary
# @param [Int] words (default: 1) Number of words in name
# @return [String] The generated name
exports.generateMarkov = (min=5, max=10, unique=false, words=1) ->
	name = []
	for i in [0...words]
		name.push chain.generateWord(min,max,false)

	return name.join(' ')

# Random number of words
# @param [Int] min (default: 1) Minimum words
# @param [Int] max (default: 3) Maximum words
# @return [String] The generated name
exports.randomMarkov = (min=1, max=3) ->
	words = Math.floor(Math.random() * (max - min + 1)) + min
	return @generateMarkov(3, 10, true, words)