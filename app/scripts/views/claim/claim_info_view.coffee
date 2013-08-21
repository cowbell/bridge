@Bridge.ClaimInfoView = Ember.View.extend
  classNames: ["alert alert-info"]
  templateName: "claim/claim_info"

  isClaimedBinding: "context.isClaimed"

  isVisible: (->
    @get("isClaimed")
  ).property("isClaimed")
