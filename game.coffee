fs = require 'fs'
owl = fs.readFileSync 'OWL.txt', 'utf8'

wordList = owl.match /^(\w+)/mg
wordList = word for word in wordList when word.length <= GRID_SIZE

isWord = (str) ->
  str in wordList

# Probabilities from Scrabble
# http://www.hasbro.com/scrabble/en_US/faqGeneral.cfm
tileCounts =
  A: 9, B: 2, C: 2, D: 4, E: 12, F: 2, G: 3
  H: 2, I: 9, J: 1, K: 1, L: 4,  M: 2, N: 6
  O: 8, P: 2, Q: 1, R: 6, S: 4,  T: 6, U: 4
  V: 2, W: 2, X: 1, Y: 2, Z: 1
totalTiles = 0
totalTiles += (count for letter, count of tileCounts)

# JS hashes are unordered so we need to make our own key array
alphabet = (letter for letter of tileCounts).sort()

randomLetter = ->
  randomNumber = Math.ceil Math.random() * totalTiles
  x = 1
  for letter in alphabet
    x += tileCounts[letter]
    letter if x > randomNumber

# grid is a 2D array: grid[col][row]
grid = for x in [0...GRID_SIZE]
  for y in [0...GRID_SIZE]
    randomLetter()

printGrid = ->
  rows = for x in [0...GRID_SIZE]
    for y in [0...GRID_SIZE]
      grid[y][x]
  rowStrings = (' ' + row.join(' | ') for row in rows)
  rowSeparator = ('-' for i in [1...GRID_SIZE * 4]).join('')
  console.log '\n' + rowStrings.join("\n#{rowSeparator}\n") + '\n'

