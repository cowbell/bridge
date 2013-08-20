@Bridge.Tables = Ember.ArrayProxy.extend
  reload: ->
    $.ajax("/api/tables").done (payload) =>
      tables = payload.tables.forEach (table) => @merge(table)
      @setProperties(isLoaded: true)

  merge: (attributes) ->
    if table = @findProperty("id", attributes.id)
      table.setProperties(attributes)
    else
      @pushObject(Bridge.Table.create(attributes))

  remove: (attributes) ->
    if table = @findProperty("id", attributes.id)
      @removeObject(table)
