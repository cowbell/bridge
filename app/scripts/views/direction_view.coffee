@Bridge.DirectionView = Ember.View.extend
  classNames: ["hand-direction"]
  classNameBindings: ["current"]
  templateName: "direction"
  tagName: "h3"

  current: (->
    @get("context.currentDirection") == @get("direction")
  ).property("context.currentDirection")

  userName: (->
    direction = @get("direction").toLowerCase()
    @get("context.user_#{direction}.email")
  ).property("context.user_n", "context.user_e", "context.user_s", "context.user_w")
