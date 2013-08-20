@Bridge.TableController = Ember.ObjectController.extend
  needs: ["bidding_box", "hand_n", "hand_e", "hand_s", "hand_w", "trick", "summary", "auction", "socket", "claim"]

  currentDirection: null
  currentDirectionBinding: "board.currentDirection"

  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")

  signedInUserDirection: (->
    @get("content").userDirection(Bridge.get("session.userId"))
  ).property("user_n", "user_e", "user_s", "user_w")

  join: (direction) ->
    @get("content").join(direction)

  quit: (direction) ->
    @get("content").quit(direction)
