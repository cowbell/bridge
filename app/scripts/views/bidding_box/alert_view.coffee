@Bridge.AlertView = Ember.View.extend
  classNames: ["btn btn-warning"]
  classNameBindings: ["active"]
  template: -> "Alert"
  tagName: "button"

  active: (->
    @get("context.isAlerted")
  ).property("context.isAlerted")

  click: ->
    @set("context.isAlerted", !@get("context.isAlerted"))
