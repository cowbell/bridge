@Bridge.Session = Ember.Object.extend
  isSignedIn: (->
    !!@get("userId")
  ).property("userId")

  signIn: (credentials) ->
    $.ajax "/api/session",
      type: "post"
      data: session: credentials
    .done (payload) =>
      @setProperties
        userId: payload.session.id
        userEmail: payload.session.email
        socketId: payload.session.socket_id

  signOut: ->
    $.ajax "/api/session",
      type: "delete"
    .done =>
      @setProperties
        userId: undefined
        email: undefined
        socketId: undefined
