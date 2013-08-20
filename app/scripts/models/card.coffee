@Bridge.Card = Ember.Object.extend
  value: (-> @get("content")[1]).property("content")
  suit: (-> @get("content")[0]).property("content")
  side: (-> if /N|S/.test(@get("direction")) then "NS" else "EW").property("direction")
  isLead: (-> @get("index") % 4 == 0).property("index")
  trick: (-> Math.floor(@get("index") / 4)).property("index")

  toString: -> @get("content")
