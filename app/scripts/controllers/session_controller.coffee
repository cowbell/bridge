@Bridge.SessionController = Ember.Controller.extend
  isSignedInBinding: "Bridge.session.isSignedIn"
  userNameBinding: "Bridge.session.userEmail"

  signIn: ->
    Bridge.get("session").signIn(email: @get("email")).done =>
      @transitionToRoute("index")

  signOut: ->
    Bridge.get("session").signOut().done =>
      @set("email", undefined)
      @transitionToRoute("signIn")
