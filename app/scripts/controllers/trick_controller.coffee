@Bridge.TrickController = Ember.Controller.extend
  needs: ["table"]

  play: Ember.computed.alias("controllers.table.board.play")
  trickNumber: Ember.computed.alias("play.lastObject.trick")

  getCard: (direction) ->
    @get("play")?.find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == direction)

  n: (->
    @getCard("N")
  ).property("trickNumber", "play.@each")

  e: (->
    @getCard("E")
  ).property("trickNumber", "play.@each")

  s: (->
    @getCard("S")
  ).property("trickNumber", "play.@each")

  w: (->
    @getCard("W")
  ).property("trickNumber", "play.@each")
