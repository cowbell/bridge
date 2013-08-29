@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["table"]

  auction: Ember.computed.alias("controllers.table.board.auction")
  contract: Ember.computed.alias("auction.contract")
  contractDirection: Ember.computed.alias("contract.direction")
  contractSide: Ember.computed.alias("contract.side")
  contractLevel: Ember.computed.alias("contract.level")
  contractTrump: Ember.computed.alias("contract.trump")
  contractBid: Ember.computed.alias("contract.bid")

  isContractDoubled: Ember.computed.alias("contract.isDoubled")
  isContractRedoubled: Ember.computed.alias("contract.isRedoubled")

  currentDirection: Ember.computed.alias("auction.currentDirection")
  currentSide: Ember.computed.alias("auction.currentSide")
  isCompleted: Ember.computed.alias("auction.isCompleted")

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
