@Bridge.IndexController = Ember.ArrayController.extend
  needs: ["socket"]

  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")

  createTable: ->
    Bridge.Table.create().save()
