@Bridge.Bid = Ember.Object.extend
  isContract: (-> /^\d/.test(@get("content"))).property("content")
  isPass: (-> @get("content") == "PASS").property("content")
  isDouble: (-> @get("content") == "X").property("content")
  isRedouble: (-> @get("content") == "XX").property("content")
  isModifier: (-> /^X/.test(@get("content"))).property("content")
  level: (-> parseInt(@get("content")[0], 10) if @get("isContract")).property("content", "isContract")
  trump: (-> @get("content")[1..-1] if @get("isContract")).property("content", "isContract")
  side: (-> if /N|S/.test(@get("direction")) then "NS" else "EW").property("direction")

  toString: -> @get("content")

  compact: ((key, value) ->
    if arguments.length == 1 # getter
      [@get("content"), @get("alert")].without(undefined).join("!")
    else # setter
      splitted = value.split("!", 2)
      @set("content", splitted[0])
      @set("alert", splitted[1])
  ).property("content", "alert")

  save: (boardId) ->
    $.ajax "/api/boards/#{boardId}/bids",
      type: "post"
      data: bid: @getProperties("content", "alert")
