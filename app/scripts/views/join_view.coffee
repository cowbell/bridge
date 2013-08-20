@Bridge.JoinView = Ember.View.extend
  classNames: ["btn"]
  templateName: "join"
  tagName: "button"

  isVisible: (->
    !@get("context.signedInUserDirection") and
    !@get("context.user_#{@get('direction').toLowerCase()}")
  ).property("context.signedInUserDirection", "context.user_n", "context.user_e", "context.user_s", "context.user_w")

  click: ->
    @get("context").join(@get("direction"))
