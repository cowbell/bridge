@Bridge.ClaimController = Ember.ObjectController.extend
  needs: ["table"]

  # http://stackoverflow.com/questions/12502465/bindings-on-objectcontroller-ember-js
  contentBinding: "controllers.table.board.claim"
  signedInUserDirection: null
  signedInUserDirectionBinding: "controllers.table.signedInUserDirection"
  play: null
  playBinding: "controllers.table.board.play"
  declarer: null
  declarerBinding: "play.declarer"
  dummy: null
  dummyBinding: "play.dummy"
  lho: null
  lhoBinding: "play.lho"
  rho: null
  rhoBinding: "play.rho"

  isEnabled: (->
    !!@get("play.contract")
  ).property("play.contract")

  isResolved: (->
    @get("isAccepted") or @get("isRejected")
  ).property("isAccepted", "isRejected")

  isClaimed: (->
    !Ember.isNone(@get("tricks")) and !@get("isResolved")
  ).property("tricks", "isResolved")

  acceptConditionDirections: (->
    switch @get("direction")
      when @get("declarer") then [@get("lho"), @get("rho")]
      when @get("lho"), @get("rho") then [@get("declarer")]
  ).property("direction", "declarer", "lho", "rho")

  isAccepted: (->
    return false if Ember.isNone(@get("accepted"))
    @get("acceptConditionDirections")?.every (direction) => @get("accepted").contains(direction)
  ).property("accepted", "acceptConditionDirections")

  isRejected: (->
    return false if Ember.isNone(@get("rejected.length"))
    @get("rejected.length") > 0
  ).property("rejected.length")

  winningCards: (->
    @get("play")?.filterProperty("isWinning")
  ).property("play.@each")

  max: (->
    13 - @get("winningCards")?.length || 0
  ).property("winningCards.@each")

  claim: (direction, value) ->
    @setProperties(tricks: value, direction: direction)
    @get("content").save(@get("controllers.table.board.id"))

  accept: (direction) ->
    @get("content").accept(@get("controllers.table.board.id"), direction)

  reject: (direction) ->
    @get("content").reject(@get("controllers.table.board.id"), direction)
