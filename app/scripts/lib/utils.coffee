# Returns sorted cards by given trump suit and values from highest to lowest.
#
# examples:
#   sortCards(["C3", "DK" "HA", "ST"], "H") => ["HA", "ST", "DK", "C3"]
#   sortCards(["C3", "DK" "HA", "ST"]) => ["ST", "HA", "C3", "DK"]

sortCards = (cards, trump) =>
  suits = (cards.map (card) -> card[0]).uniq()
  sortedSuits = sortCardSuits(suits, trump)
  sortedValues = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
  # Ember.copy is necessary since sort function modifies array, which is not catched by Ember later on,
  # because all content changes should be done via set function.
  Ember.copy(cards).sort (a, b) ->
    if a[0] == b[0]
      sortedValues.indexOf(a[1]) - sortedValues.indexOf(b[1])
    else
      sortedSuits.indexOf(a[0]) - sortedSuits.indexOf(b[0])

sortCardSuits = (suits, trump) ->
  black = ["S", "C"].filter (s) -> s in suits
  red   = ["H", "D"].filter (s) -> s in suits
  if black.contains(trump)
    black.splice(black.indexOf(trump), 1).concat(red.splice(0, 1), black.splice(0, 1), red.splice(0, 1))
  else if red.contains(trump)
    red.splice(red.indexOf(trump), 1).concat(black.splice(0, 1), red.splice(0, 1), black.splice(0, 1))
  else if black.length >= red.length
    black.splice(0, 1).concat(red.splice(0, 1), black.splice(0, 1), red.splice(0, 1))
  else
    red.splice(0, 1).concat(black.splice(0, 1), red.splice(0, 1), black.splice(0, 1))

# Returns a winning card from given trick, using given trump.
#
# examples:
#   trickWinner(["CA", "H2", "SA", "DA"], "H") => "H2"
#   trickWinner(["C2", "H2", "C4", "CJ"], undefined) => "CJ"

trickWinner = (trick, trump) ->
  order = (card) -> Bridge.CARDS.indexOf(card)
  reverse = (a, b) -> b - a
  suit = trick[0][0]
  suits = trick.filter (card) -> card[0] == suit
  suitIndices = suits.map(order).sort(reverse)
  trumps = trick.filter (card) -> card[0] == trump
  trumpIndices = trumps.map(order).sort(reverse)
  Bridge.CARDS[trumpIndices[0] or suitIndices[0]]

# Returns an array containing subsequent directions for corresponding
# bids array and given dealer.
#
# examples:
#   auctionDirections("N", ["PASS", "1NT"]) => ["N", "E"]
auctionDirections = (dealer, bids) ->
  dealerIndex = Bridge.DIRECTIONS.indexOf(dealer)
  bids.map (bid, i) -> Bridge.DIRECTIONS[(dealerIndex + i) % 4]

# Extracts a contract from given bids and dealer direction.
#
# examples:
#   auctionContract("N", ["1NT", "PASS", "2NT", "X", "XX"]) => "2NTXXN"
auctionContract = (dealer, bids) ->
  contracts = bids.filter (bid) -> /^\d/.test(bid)
  lastContract = contracts[contracts.length - 1]
  if lastContract?
    dealerIndex = Bridge.DIRECTIONS.indexOf(dealer)
    lastContractIndex = bids.indexOf(lastContract)
    firstBidWithContractSuit = bids.find (bid, i) -> bid[1] == lastContract[1] and lastContractIndex % 2 == i % 2
    firstBidWithContractSuitIndex = bids.indexOf(firstBidWithContractSuit)
    double = if bids.slice(lastContractIndex).indexOf("X") != -1 then "X" else ""
    redouble = if bids.slice(lastContractIndex).indexOf("XX") != -1 then "X" else ""
    declarerDirection = Bridge.DIRECTIONS[(dealerIndex + firstBidWithContractSuitIndex) % 4]
    "#{lastContract}#{double}#{redouble}#{declarerDirection}"

# Returns an array containing subsequent directions for corresponding
# cards array, given trump and declarer direction.
#
# examples:
#   playDirections("N", "H", ["H2", "H5", "HA", "C2", "S5"]) => ["E", "S", "W", "N", "W"]
playDirections = (declarer, trump, cards) ->
  directionIndex = Bridge.DIRECTIONS.indexOf(declarer)
  cards.map (card, i) ->
    if i > 0 and i % 4 == 0
      lastTrickNumber = Math.floor(i / 4) - 1
      lastTrick = cards.slice(lastTrickNumber * 4, lastTrickNumber * 4 + 4)
      lastTrickWinner = trickWinner(lastTrick, trump)
      lastTrickWinnerIndex = lastTrick.indexOf(lastTrickWinner)
      directionIndex += lastTrickWinnerIndex
    Bridge.DIRECTIONS[++directionIndex % 4]

# Returns score for given contract and tricks number taken by declarer side.
#
# examples:
#   score("4HE", 10) => 0
#   score("4HE", 9) => -1
#   score("6NTXXS", 13) => 1
score = (contract, tricksNumber) ->
  level = parseInt(contract[0], 10)
  tricksNumber - (level + 6)

@Bridge.Utils =
  sortCards:         sortCards
  sortCardSuits:     sortCardSuits
  trickWinner:       trickWinner
  auctionDirections: auctionDirections
  auctionContract:   auctionContract
  playDirections:    playDirections
  score:             score
