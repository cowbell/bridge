@Bridge.ClaimController = Ember.Controller.extend
  needs: ["table"]

  boardBinding: "controllers.table.board"
  currentDirectionBinding: "board.play.currentDirection"
  playBinding: "board.play"

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

  claim: (value) ->
    @get("board").set("claim", "#{@get('currentDirection')}#{value}")
