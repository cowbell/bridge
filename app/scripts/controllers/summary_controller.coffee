@Bridge.SummaryController = Ember.Controller.extend
  needs: ["table"]

  auction: Ember.computed.alias("controllers.table.board.auction")
  play: Ember.computed.alias("controllers.table.board.play")
  dealer: Ember.computed.alias("controllers.table.board.dealer")
  vulnerable: Ember.computed.alias("controllers.table.board.vulnerable")
  result: Ember.computed.alias("controllers.table.board.result")
  nsWonTricksNumber: Ember.computed.alias("play.nsWonTricksNumber")
  ewWonTricksNumber: Ember.computed.alias("play.ewWonTricksNumber")

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
