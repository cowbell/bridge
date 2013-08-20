@Bridge.AuctionController = Ember.ArrayController.extend
  needs: ["table"]

  auctionBinding: "controllers.table.board.auction"
  dealerBinding: "controllers.table.board.auction.dealer"
  dealerIndex: (-> Bridge.DIRECTIONS.indexOf(@get("dealer"))).property("dealer")

  # TODO: use array observers

  content: (->
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
