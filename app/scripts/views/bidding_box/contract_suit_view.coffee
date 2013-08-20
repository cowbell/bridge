@Bridge.ContractSuitView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "bidding_box/contract_suit"
  tagName: "button"

  disabled: (->
    @get("context.isCompleted") or
      Bridge.CONTRACTS.indexOf(@get("context.contractBid")) >= Bridge.CONTRACTS.indexOf(@get("context.level") + @get("suit"))
  ).property("context.isCompleted", "context.contractBid", "context.level", "suit")

  click: -> @get("context").bid(@get("context.level") + @get("suit"))
