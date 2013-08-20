@Bridge.HandCardView = Bridge.CardView.extend
  isDisabled: (->
    !@get("context.isPlaying") or
    !@get("context.isEnabled") or
    @get("card.content") == "" or
    @get("context.currentDirection") != @get("ownerDirection") or
    (@get("context.currentSuit")? and @get("context.currentSuit") != @get("card.suit") and @get("context.hasCardInCurrentSuit"))
  ).property("content","context.isPlaying", "context.currentDirection", "context.currentSuit", "context.hasCardInCurrentSuit")

  click: ->
    @get("context").playCard(@get("card")) unless @get("isDisabled")
