@Bridge.Board = Ember.Object.extend
  init: ->
    @_super.apply(@, arguments)
    # @set("auction", Bridge.Auction.create(content: @get("bids"), dealer: @get("dealer")))
    # @set("play", Bridge.Play.create(content: @get("cards"), contract: Ember.computed.alias("board.contract")))

  setupModels: (->
    @set("auction", Bridge.Auction.create(content: @get("bids"), dealer: @get("dealer")))
    @set("play", Bridge.Play.create(content: @get("cards")))
  ).on("init")

  auctionIsCompletedDidChange: (->
    if @get("auction.isCompleted")
      @get("play").set("contract", @get("auction.contract"))
  ).observes("auction.isCompleted")

  contract: (->
    @get("auction.contract") if @get("auction.isCompleted")
  ).property("auction.contract", "auction.isCompleted")

  currentDirection: (->
    if @get("auction.isCompleted") then @get("play.currentDirection") else @get("auction.currentDirection")
  ).property("auction.isCompleted", "auction.currentDirection", "play.currentDirection")

  result: (->
    if @get("play.isCompleted")
      @get("play.declarerSideWonTricksNumber") - @get("contract.tricksToMake")
    else if claim = @get("claim")
      claimTricksNumber = parseInt(claim[1..-1], 10)
      switch claim[0] # claim direction
        when @get("play.declarer"), @get("play.dummy")
          @get("play.declarerSideWonTricksNumber") + claimTricksNumber - @get("contract.tricksToMake")
        when @get("play.lho"), @get("play.rho")
          13 - @get("play.winningCards").length - claimTricksNumber - @get("contract.tricksToMake")
  ).property("play.isCompleted", "contract.tricksToMake", "play.declarerSideWonTricksNumber", "claim")

  isFinished: (->
    !Ember.isNone(@get("result"))
  ).property("result")
