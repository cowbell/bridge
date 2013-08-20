@Bridge.CardView = Ember.View.extend
  classNames: ["card"]
  classNameBindings: ["isDisabled:disabled", "suitClassName"]

  templateName: (->
    name = if @get("card.value") then @get("card.value").toLowerCase() else "unknown"
    "cards/#{name}"
  ).property("card.value")

  templateNameDidChange: (->
    Ember.run.next => @rerender()
  ).observes("templateName")

  suitClassName: (->
    "suit-#{@get("card.suit").toLowerCase()}" if @get("card.suit")
  ).property("card.suit")

  isDisabled: true
