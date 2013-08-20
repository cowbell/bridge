Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: ->
    Bridge.Tables.create(content: [])

  setupController: (controller, model) ->
    @_super(controller, model)
    @controllerFor("socket").set("channel", "tables")

  activate: ->
    socket = @controllerFor("socket").get("content")
    socket.on("tables/create", @, @mergeTable)
    socket.on("tables/update", @, @mergeTable)
    socket.on("tables/destroy", @, @removeTable)

  deactivate: ->
    socket = @controllerFor("socket").get("content")
    socket.off("tables/create", @, @mergeTable)
    socket.off("tables/update", @, @mergeTable)
    socket.off("tables/destroy", @, @removeTable)

  mergeTable: (payload) ->
    @modelFor("index").merge(payload.table)

  removeTable: (payload) ->
    @modelFor("index").remove(payload.table)
