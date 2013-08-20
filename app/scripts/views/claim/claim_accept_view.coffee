@Bridge.ClaimAcceptView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_accept"
  tagName: "button"

  isVisible: (->
    @get("context.isClaimed") and
    @get("context.signedInUserDirection") == @get("direction") and
    @get("direction") != @get("context.dummy") and
    @get("context.acceptConditionDirections")?.contains(@get("direction"))
  ).property("context.isClaimed", "context.acceptConditionDirections", "context.dummy", "context.signedInUserDirection")

  disabled: (->
    @get("context.isAccepted") or
    @get("context.accepted")?.contains(@get("direction"))
  ).property("context.accepted.@each", "context.isAccepted")

  click: ->
    @get("context").accept(@get("direction"))
