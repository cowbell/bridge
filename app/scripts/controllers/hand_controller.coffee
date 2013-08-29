@Bridge.HandController = Ember.ArrayController.extend
  needs: ["table"]

  board: Ember.computed.alias("controllers.table.board")
  play: Ember.computed.alias("controllers.table.board.play")
  dummy: Ember.computed.alias("play.dummy")
  currentSuit: Ember.computed.alias("play.currentSuit")
  currentDirection: Ember.computed.alias("play.currentDirection")
  contract: Ember.computed.alias("play.contract")
  trump: Ember.computed.alias("contract.trump")

  isDummy: (->
    @get("direction") == @get("dummy")
  ).property("direction", "dummy")

  playDidChange: (->
    if play = @get("play")
      play.addArrayObserver(@, willChange: @playContentWillChange, didChange: @playContentDidChange)
  ).observes("play.content.@each")

  playWillChange: (->
    if play = @get("play")
      play.removeArrayObserver(@)
  ).observesBefore("play.content.@each")

  initialDidChange: (->
    cards = Bridge.Utils.sortCards(@get("initial") || ["", "", "", "", "", "", "", "", "", "", "", "", ""], @get("trump"))
    @set("content", cards.map (card) -> Bridge.Card.create(content: card))
    @playContentDidChange(@get("play"), 0, 0, @get("play.length"))
  ).observes("initial", "trump").on("init")

  # unlikely to happen, but when it does, we just add a card to the end of hand
  playContentWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        card = content.objectAt(i)
        @pushObject(card) if card.get("direction") == @get("direction")

  playContentDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        card = content.objectAt(i)
        cardContent = card.get("content")
        if card.get("direction") == @get("direction")
          if handCard = @findProperty("content", cardContent) then @removeObject(handCard) else @popObject()

  isPlaying: (->
    !!@get("contract") and !@get("board.isFinished")
  ).property("contract", "board.isFinished")

  hasCardInCurrentSuit: (->
    @someProperty("suit", @get("currentSuit"))
  ).property("@each", "currentSuit")

  playCard: (card) ->
    @get("play").pushObject(card.get("content"))

Bridge.register "controller:hand_n", Bridge.HandController.extend
  direction: "N"
  initial: Ember.computed.alias("controllers.table.board.n")

Bridge.register "controller:hand_e", Bridge.HandController.extend
  direction: "E"
  initial: Ember.computed.alias("controllers.table.board.e")

Bridge.register "controller:hand_s", Bridge.HandController.extend
  direction: "S"
  initial: Ember.computed.alias("controllers.table.board.s")

Bridge.register "controller:hand_w", Bridge.HandController.extend
  direction: "W"
  initial: Ember.computed.alias("controllers.table.board.w")
