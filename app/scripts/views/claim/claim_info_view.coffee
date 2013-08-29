@Bridge.ClaimInfoView = Ember.View.extend
  classNames: ["alert alert-info"]
  templateName: "claim/claim_info"

  isClaimed: Ember.computed.alias("context.isClaimed")

  isVisible: (->
    @get("isClaimed")
  ).property("isClaimed")
