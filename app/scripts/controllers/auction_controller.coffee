@Bridge.AuctionController = Ember.Controller.extend
  needs: ["table"]

  auction: Ember.computed.alias("controllers.table.board.auction")
  dealer: Ember.computed.alias("auction.dealer")
  dealerIndex: (-> Bridge.DIRECTIONS.indexOf(@get("dealer"))).property("dealer")

  # TODO: use array observers
  rows: (->
    dealerIndex = @get("dealerIndex")
    auctionLength = @get("auction.length")
    if dealerIndex? and auctionLength
      rows = Math.floor((dealerIndex + @get("auction.length") - 1) / 4)
      for row in [0..rows]
        Ember.Object.create
          n: @get("auction.arrangedContent.#{row * 4 - dealerIndex}")
          e: @get("auction.arrangedContent.#{row * 4 - dealerIndex + 1}")
          s: @get("auction.arrangedContent.#{row * 4 - dealerIndex + 2}")
          w: @get("auction.arrangedContent.#{row * 4 - dealerIndex + 3}")
    else
      []
  ).property("auction.@each", "dealerIndex")
