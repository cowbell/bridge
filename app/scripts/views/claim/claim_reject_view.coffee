@Bridge.ClaimRejectView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_reject"
  tagName: "button"

  isVisible: (->
    @get("context.isClaimed") and
    @get("context.signedInUserDirection") == @get("direction") and
    @get("direction") != @get("context.dummy")
  ).property("context.isClaimed", "context.dummy", "context.signedInUserDirection")

  disabled: (->
    @get("context.isAccepted") or @get("context.isRejected")
  ).property("context.isAccepted", "context.isRejected")

  click: ->
    @get("context").reject(@get("direction"))
