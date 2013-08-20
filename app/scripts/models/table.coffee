userSetter = (key, value) ->
  if arguments.length == 2
    if not value? or value instanceof Bridge.User then value else Bridge.User.create(value)

@Bridge.Table = Ember.Object.extend
  name: (-> "Table #{@get('id')}").property("id")

  user_n: (userSetter).property()
  user_e: (userSetter).property()
  user_s: (userSetter).property()
  user_w: (userSetter).property()

  currentUser: (->
    currentDirection = @get("board.currentDirection")
    @get("user_#{currentDirection.toLowerCase()}") if currentDirection
  ).property("board.currentDirection", "user_n", "user_e", "user_s", "user_w")

  declarerUser: (->
    declarer = @get("board.play.declarer")
    @get("user_#{declarer.toLowerCase()}") if declarer
  ).property("board.play.declarer", "user_n", "user_e", "user_s", "user_w")

  board: ((key, value) ->
    if arguments.length == 2
      if not value? or value instanceof Bridge.Board
        value
      else
        Bridge.Board.create(value)
  ).property()

  userDirection: (userId) ->
    switch userId
      when @get("user_n.id") then "N"
      when @get("user_e.id") then "E"
      when @get("user_s.id") then "S"
      when @get("user_w.id") then "W"

  reload: ->
    @setProperties
      id: 2
      user_n: null
      user_e: null
      user_s: null
      user_w: null
      board:
        id: 3
        dealer: "N"
        vulnerable: "NONE"
        bids: ["7S", "PASS", "PASS", "PASS"]
        cards: []
        n: []
        e: []
        s: []
        w: []
        result: null
        claim: null

  save: ->
    $.ajax "/api/tables",
      type: "post"
    .done (payload) =>
      @setProperties(payload.table)

  join: (direction) ->
    $.ajax "/api/tables/#{@get('id')}/join",
      type: "patch"
      data: table: {direction: direction}

  quit: (direction) ->
    $.ajax "/api/tables/#{@get('id')}/quit",
      type: "patch"
      data: table: {direction: direction}
