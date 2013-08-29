@Bridge.ClaimView = Ember.View.extend
  classNames: ["btn-group"]
  templateName: "claim/claim"

  direction: Ember.computed.alias("context.currentDirection")

  isVisible: (->
    !@get("context.isClaimed")
  ).property("context.isClaimed")

  range: (->
    num for num in [0..@get("context.max")]
  ).property("context.max")
