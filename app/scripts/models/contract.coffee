@Bridge.Contract = Ember.Object.extend
  level: (-> parseInt(@get("content")[0], 10)).property("content")
  trump: (-> /^\d(C|D|H|S|NT)/.exec(@get("content"))[1]).property("content")
  direction: (-> @get("content")[-1..-1]).property("content")
  isDoubled: (-> /^\d(C|D|H|S|NT)X[^X]/.test(@get("content"))).property("content")
  isRedoubled: (-> /^\d(C|D|H|S|NT)XX/.test(@get("content"))).property("content")
  side: (-> if /N|S/.test(@get("direction")) then "NS" else "EW").property("direction")
  bid: (-> /^[1-7](?:C|D|H|S|NT)/.exec(@get("content"))[0]).property("content")

  toString: -> @get("content")
