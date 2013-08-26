@Bridge.Play = Ember.ArrayProxy.extend
  contract: ((key, value) ->
    if arguments.length == 2
      if not value? or value instanceof Bridge.Contract
        value
      else
        Bridge.Contract.create(content: value)
  ).property()

  arrangedContent: (->
    @get("content").map (card, i) -> Bridge.Card.create(content: card)
  ).property()

  contentArrayWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        @get("arrangedContent").removeAt(i)

  contentArrayDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        @get("arrangedContent").insertAt(i, Bridge.Card.create(content: content.objectAt(i)))

  trumpBinding: "contract.trump"
  declarerBinding: "contract.direction"
  dummy: (-> {N: "S", E: "W", S: "N", W: "E"}[@get("declarer")]).property("declarer")
  lho: (-> {N: "E", E: "S", S: "W", W: "N"}[@get("declarer")]).property("declarer")
  rho: (-> {N: "W", E: "N", S: "E", W: "S"}[@get("declarer")]).property("declarer")

  init: ->
    @_super.apply(@, arguments)
    @reindex()

  reindex: (->
    Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content").concat("")).forEach (direction, i, directions) =>
      if card = @objectAt(i)
        winningCardIndex = Math.floor(i / 4) * 4 + 4
        card.setProperties(index: i, direction: direction, isWinning: direction == directions[winningCardIndex])
      else
        @set("currentDirection", direction)
  ).observes("declarer", "trump", "arrangedContent.@each")

  isCompleted: (->
    @get("length") == 52
  ).property("length")

  currentSuit: (->
    @filterProperty("isLead").get("lastObject.suit") if @get("length") % 4 != 0
  ).property("length", "arrangedContent.@each")

  winningCards: (->
    @filterProperty("isWinning")
  ).property("arrangedContent.@each.isWinning")

  nsWonTricksNumber: (->
    @get("winningCards")?.filterProperty("side", "NS").length
  ).property("winningCards.@each")

  ewWonTricksNumber: (->
    @get("winningCards")?.filterProperty("side", "EW").length
  ).property("winningCards.@each")

  declarerSideWonTricksNumber: (->
    switch @get("declarer")
      when "N", "S"
        @get("nsWonTricksNumber")
      when "E", "W"
        @get("ewWonTricksNumber")
  ).property("declarer", "nsWonTricksNumber", "ewWonTricksNumber")
