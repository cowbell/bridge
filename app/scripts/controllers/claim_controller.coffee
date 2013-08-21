@Bridge.ClaimController = Ember.ObjectController.extend
  needs: ["table"]

  # http://stackoverflow.com/questions/12502465/bindings-on-objectcontroller-ember-js
  contentBinding: "controllers.table.board.claim"
  currentDirectionBinding: "controllers.table.currentDirection"
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
    # @get("content").save(@get("controllers.table.board.id"))
    # @get("content").accept(@get("controllers.table.board.id"), direction)
