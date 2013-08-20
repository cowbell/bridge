@Bridge.QuitView = Ember.View.extend
  classNames: ["btn"]
  templateName: "quit"
  tagName: "button"

  isVisible: (->
    @get("context.signedInUserDirection") == @get("direction")
  ).property("context.signedInUserDirection")

  click: ->
    @get("context").quit(@get("direction"))
