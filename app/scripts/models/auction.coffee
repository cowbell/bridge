@Bridge.Auction = Ember.ArrayProxy.extend
  init: ->
    @_super.apply(@, arguments)
    @reindex()

  arrangedContent: (->
    @get("content").map (bid, i) -> Bridge.Bid.create(compact: bid)
  ).property()

  contentArrayWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        @get("arrangedContent").removeAt(i)

  contentArrayDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        @get("arrangedContent").insertAt(i, Bridge.Bid.create(compact: content.objectAt(i)))

  reindex: (->
    Bridge.Utils.auctionDirections(@get("dealer"), @get("content").concat("")).forEach (direction, i) =>
      if bid = @objectAt(i)
        bid.setProperties(index: i, direction: direction)
      else
        @set("currentDirection", direction)
  ).observes("dealer", "arrangedContent.@each")

  isCompleted: (->
    @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")
  ).property("length", "@each.isPass")

  currentSide: (->
    if /N|S/.test(@get("currentDirection")) then "NS" else "EW"
  ).property("currentDirection")

  contract: (->
    bids = @get("content").map (bid) -> new RegExp(Bridge.BIDS.join("|")).exec(bid)[0]
    contract = Bridge.Utils.auctionContract(@get("dealer"), bids)
    Bridge.Contract.create(content: contract) if contract?
  ).property("isCompleted", "content.@each")
