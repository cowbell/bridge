@Bridge.ClaimController = Ember.Controller.extend
  needs: ["table"]

  currentDirectionBinding: "controllers.table.board.play.currentDirection"
  play: null
  playBinding: "controllers.table.board.play"

  isEnabled: (->
    !!@get("play.contract")
  ).property("play.contract")

  isClaimed: (->
    !Ember.isNone(@get("tricks"))
  ).property("tricks")

  winningCards: (->
    @get("play")?.filterProperty("isWinning")
  ).property("play.@each")

  max: (->
    13 - @get("winningCards")?.length || 0
  ).property("winningCards.@each")

  claim: (value) ->
    @setProperties(tricks: value, direction: @get("currentDirection"))
    @get("controllers.table.board").set("claim", "#{@get('direction')}#{value}")
