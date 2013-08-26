@Bridge.SummaryController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.board.auction"
  playBinding: "controllers.table.board.play"
  dealerBinding: "controllers.table.board.dealer"
  vulnerableBinding: "controllers.table.board.vulnerable"
  resultBinding: "controllers.table.board.result"
  nsWonTricksNumberBinding: "play.nsWonTricksNumber"
  ewWonTricksNumberBinding: "play.ewWonTricksNumber"

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

  isNSvulnerable: (->
    @get("vulnerable") in ["BOTH", "NS"]
  ).property("vulnerable")

  isEWvulnerable: (->
    @get("vulnerable") in ["BOTH", "EW"]
  ).property("vulnerable")
