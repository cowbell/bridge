@Bridge.ClaimController = Ember.Controller.extend
  needs: ["table"]

  board: Ember.computed.alias("controllers.table.board")
  play: Ember.computed.alias("board.play")
  currentDirection: Ember.computed.alias("play.currentDirection")

  isEnabled: (->
    !!@get("play.contract")
  ).property("play.contract")

  isClaimed: (->
    !Ember.isNone(@get("tricks"))
  ).property("tricks")

  winningCards: (->
    @get("play")?.filterProperty("isWinning")
  ).property("play.@each")

  tricks: (->
    @get("board.claim")?[1..-1]
  ).property("board.claim")

  direction: (->
    @get("board.claim")?[0]
  ).property("board.claim")

  max: (->
    13 - @get("winningCards")?.length || 0
  ).property("winningCards.@each")

  actions:
    claim: (value) ->
      @get("board").set("claim", "#{@get('currentDirection')}#{value}")
