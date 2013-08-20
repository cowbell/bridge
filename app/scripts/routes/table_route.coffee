Bridge.TableRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: (params) ->
    Bridge.Table.create(id: params.table_id)

  serialize: (model) ->
    table_id: model.get("id")

  setupController: (controller, model) ->
    @_super(controller, model)
    @controllerFor("socket").set("channel", "tables/#{model.get('id')}")

  activate: ->
    socket = @controllerFor("socket").get("content")
    socket.on("bids/create", @, @createBid)
    socket.on("cards/create", @, @createCard)
    socket.on("table/update", @, @updateTable)
    socket.on("board/update", @, @updateBoard)
    socket.on("claim/update", @, @updateClaim)

  deactivate: ->
    socket = @controllerFor("socket").get("content")
    socket.off("bids/create", @, @createBid)
    socket.off("cards/create", @, @createCard)
    socket.off("table/update", @, @updateTable)
    socket.off("board/update", @, @updateBoard)
    socket.off("claim/update", @, @updateClaim)

  createBid: (payload) ->
    @modelFor("table").get("board.auction")?.pushObject(payload.bid.content)

  createCard: (payload) ->
    @modelFor("table").get("board.play")?.pushObject(payload.card.content)

  updateTable: (payload) ->
    @modelFor("table").setProperties(payload.table)

  updateBoard: (payload) ->
    @modelFor("table").get("board").setProperties(payload.board)

  updateClaim: (payload) ->
    @modelFor("table").get("board.claim").setProperties(payload.claim)
