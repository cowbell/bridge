@Bridge.DoubleView = Ember.View.extend
  classNames: ["btn", "btn-danger"]
  attributeBindings: ["disabled"]
  templateName: "bidding_box/double"
  tagName: "button"

  disabled: (->
    @get("context.isCompleted") or
      not @get("context.contract") or
      @get("context.isContractDoubled") or
      @get("context.isContractRedoubled") or
      @get("context.currentSide") == @get("context.contractSide")
  ).property("context.isCompleted", "context.isContractDoubled", "context.isContractRedoubled", "context.currentSide", "context.contractSide")

  click: -> @get("context").bid("X")
