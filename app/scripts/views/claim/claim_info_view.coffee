@Bridge.ClaimInfoView = Ember.View.extend
  classNames: ["alert alert-info"]
  templateName: "claim/claim_info"

  isClaimedBinding: "context.isClaimed"
  isAcceptedBinding: "context.isAccepted"
  isRejectedBinding: "context.isRejected"

  isVisible: (->
    @get("isClaimed") or @get("isAccepted") or @get("isRejected")
  ).property("isClaimed", "isAccepted", "isRejcted")
