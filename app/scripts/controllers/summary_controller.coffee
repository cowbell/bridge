@Bridge.SummaryController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.board.auction"
  playBinding: "controllers.table.board.play"
  dealerBinding: "controllers.table.board.dealer"
  vulnerableBinding: "controllers.table.board.vulnerable"
  resultBinding: "controllers.table.board.result"

  contract: (->
    @get("auction.contract") if @get("auction.isCompleted")
  ).property("auction.isCompleted")

  resultString: (->
    result = @get("result")
    return if Ember.isNone(result)
    switch
      when result >  0 then "+#{result}"
      when result == 0 then "="
      when result <  0 then "#{result}"
  ).property("result")

  winningCards: (->
    @get("play")?.filterProperty("isWinning")
  ).property("play.@each.isWinning")

  nsWonTricksNumber: (->
    @get("winningCards")?.filterProperty("side", "NS").length
  ).property("winningCards.@each")

  ewWonTricksNumber: (->
    @get("winningCards")?.filterProperty("side", "EW").length
  ).property("winningCards.@each")

  isNSvulnerable: (->
    @get("vulnerable") in ["BOTH", "NS"]
  ).property("vulnerable")

  isEWvulnerable: (->
    @get("vulnerable") in ["BOTH", "EW"]
  ).property("vulnerable")
