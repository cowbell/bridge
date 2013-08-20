@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.board.auction"

  contractBinding: "auction.contract"
  contractDirectionBinding: "contract.direction"
  contractSideBinding: "contract.side"
  contractLevelBinding: "contract.level"
  contractTrumpBinding: "contract.trump"
  contractBidBinding: "contract.bid"
  isContractDoubledBinding: "contract.isDoubled"
  isContractRedoubledBinding: "contract.isRedoubled"

  currentDirectionBinding: "auction.currentDirection"
  currentSideBinding: "auction.currentSide"
  isCompletedBinding: "auction.isCompleted"

  isEnabled: (->
    !@get("isCompleted")
  ).property("isCompleted")

  descriptionDidChange: (->
    @set "isAlerted", !Ember.isEmpty(@get("description"))
  ).observes("description")

  isAlertedDidChange: (->
    @set("description", undefined) unless @get("isAlerted")
  ).observes("isAlerted")

  bid: (bid) ->
    alert = if @get("isAlerted") then @get("description") || "" else undefined
    compactBid = [bid, alert].without(undefined).join("!")
    @setProperties(level: null, description: undefined)
    @get("auction").pushObject(compactBid)
