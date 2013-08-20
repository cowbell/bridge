Bridge.SignInRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "index" if Bridge.get("session.isSignedIn")

  renderTemplate: ->
    @render "sign_in", controller: "session"
