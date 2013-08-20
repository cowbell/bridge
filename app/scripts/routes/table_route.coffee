Bridge.TableRoute = Ember.Route.extend
  model: (params) ->
    Bridge.Table.create(id: params.table_id)

  serialize: (model) ->
    table_id: model.get("id")
