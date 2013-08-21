@Bridge.TableController = Ember.ObjectController.extend
  needs: ["bidding_box", "hand_n", "hand_e", "hand_s", "hand_w", "trick", "summary", "auction", "claim"]

  currentDirection: null
  currentDirectionBinding: "board.currentDirection"

  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")
