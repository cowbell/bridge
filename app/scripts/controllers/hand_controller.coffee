@Bridge.HandController = Ember.ArrayController.extend
  needs: ["table"]

  playBinding: "controllers.table.board.play"
  dummyBinding: "play.dummy"
  loggedInUserIdBinding: "Bridge.session.userId"
  currentUserIdBinding: "controllers.table.currentUser.id"
  declarerUserIdBinding: "controllers.table.declarerUser.id"

  isDummy: (->
    @get("direction") == @get("dummy")
  ).property("direction", "dummy")

  isEnabled: (->
    if @get("isDummy") then @get("declarerUserId") == @get("loggedInUserId") else @get("currentUserId") == @get("loggedInUserId")
  ).property("loggedInUserId", "currentUserId", "isDummy", "declarerUserId")

  init: ->
    @_super.apply(@, arguments)
    @initialDidChange()

  playDidChange: (->
    if play = @get("play")
      play.addArrayObserver(@, willChange: @playContentWillChange, didChange: @playContentDidChange)
      @playContentDidChange(play, 0, 0, play.get("length"))
  ).observes("play")

  playWillChange: (->
    if play = @get("play")
      play.removeArrayObserver(@)
      @playContentDidChange(play, 0, play.get("length"), 0)
  ).observesBefore("play")

  initialDidChange: (->
    cards = Bridge.Utils.sortCards(@get("initial") || ["", "", "", "", "", "", "", "", "", "", "", "", ""], @get("trump"))
    @set("content", cards.map (card) -> Bridge.Card.create(content: card))
    @playContentDidChange(@get("play"), 0, 0, @get("play.length"))
  ).observes("initial", "trump")

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

  currentSuitBinding: "play.currentSuit"
  currentDirectionBinding: "play.currentDirection"
  contractBinding: "play.contract"
  trumpBinding: "contract.trump"

  isPlaying: (->
    !!@get("contract")
  ).property("contract")

  hasCardInCurrentSuit: (->
    @someProperty("suit", @get("currentSuit"))
  ).property("@each", "currentSuit")

  playCard: (card) ->
    card.save(@get("controllers.table.board.id"))

Bridge.register "controller:hand_n", Bridge.HandController.extend
  direction: "N"
  initialBinding: "controllers.table.content.board.n"

Bridge.register "controller:hand_e", Bridge.HandController.extend
  direction: "E"
  initialBinding: "controllers.table.content.board.e"

Bridge.register "controller:hand_s", Bridge.HandController.extend
  direction: "S"
  initialBinding: "controllers.table.content.board.s"

Bridge.register "controller:hand_w", Bridge.HandController.extend
  direction: "W"
  initialBinding: "controllers.table.content.board.w"
