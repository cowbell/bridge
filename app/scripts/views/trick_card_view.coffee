@Bridge.TrickCardView = Bridge.CardView.extend
  classNameBindings: ["orderClassName"]

  isVisible: (->
    !!@get("card.value")
  ).property("card.value")

  orderClassName: (->
    "order-#{@get('card.index') % 4}" unless Ember.isNone(@get("card.index"))
  ).property("card.index")
