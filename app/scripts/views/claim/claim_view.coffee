@Bridge.ClaimView = Ember.View.extend
  classNames: ["btn-group"]
  templateName: "claim/claim"

  isVisible: (->
    @get("context.signedInUserDirection") == @get("direction") and
    @get("direction") != @get("context.dummy") and
    !@get("context.isClaimed")
  ).property("context.isClaimed", "context.dummy", "context.signedInUserDirection")

  range: (->
    num for num in [0..@get("context.max")]
  ).property("context.max")
