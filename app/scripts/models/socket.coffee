connecting = Ember.State.create
  enter: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onopen  = -> stateManager.transitionTo("waiting")
    sock.onclose = -> stateManager.transitionTo("error")
    sock.onerror = -> stateManager.transitionTo("error")
    stateManager.set("socket.sock", sock)
  exit: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onopen = sock.onclose = null

waiting = Ember.State.create
  enter: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onclose = -> stateManager.transitionTo("error")
    sock.onmessage = (event) ->
      try
        payload = JSON.parse(event.data)
        nextState = if payload.event == "ready" then "authenticating" else "error"
        stateManager.transitionTo(nextState)
      catch error
        stateManager.transitionTo("error")
  exit: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onmessage = sock.onclose = null

authenticating = Ember.State.create
  enter: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onclose = -> stateManager.transitionTo("error")
    sock.onmessage = (event) ->
      try
        payload = JSON.parse(event.data)
        nextState = if payload.event == "authenticated" then "subscribing" else "error"
        stateManager.set("socket.registeredId", payload.data)
        stateManager.transitionTo(nextState)
      catch error
        stateManager.transitionTo("error")
    sock.send(JSON.stringify(event: "authenticate", data: stateManager.get("socket.id")))
  exit: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onclose = sock.onmessage = null

subscribing = Ember.State.create
  enter: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onclose = -> stateManager.transitionTo("error")
    sock.onmessage = (event) ->
      try
        payload = JSON.parse(event.data)
        nextState = if payload.event == "subscribed" then "connected" else "error"
        stateManager.set("socket.registeredChannel", payload.data)
        stateManager.transitionTo(nextState)
      catch error
        stateManager.transitionTo("error")
    sock.send(JSON.stringify(event: "subscribe", data: stateManager.get("socket.channel")))
  exit: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onclose = sock.onmessage = null

connected = Ember.State.create
  enter: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onclose = -> stateManager.transitionTo("disconnected")
    sock.onmessage = (event) ->
      try
        payload = JSON.parse(event.data)
        stateManager.get("socket").trigger(payload.event, payload.data)
      catch error
        stateManager.transitionTo("error")
  exit: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onclose = sock.onmessage = null

disconnected = Ember.State.create
  enter: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onopen = sock.onclose = sock.onmessage = sock.onerror = null
    sock.close()

error = Ember.State.create
  enter: (stateManager) ->
    sock = stateManager.get("socket.sock")
    sock.onopen = sock.onclose = sock.onmessage = sock.onerror = null
    sock.close()

@Bridge.SocketManager = Ember.StateManager.extend
  initialState: "connecting"

  states:
    connecting: connecting
    waiting: waiting
    authenticating: authenticating
    subscribing: subscribing
    connected: connected
    disconnected: disconnected
    error: error

@Bridge.Socket = Ember.Object.extend Ember.Evented,
  stateBinding: "stateManager.currentState.name"

  init: ->
    @_super.apply(@, arguments)
    @connect()

  stateDidChange: (->
    if @get("state") == "connected"
      if @get("registeredId") != @get("id")
        @get("stateManager").transitionTo("authenticating")
      else if @get("registeredChannel") != @get("channel")
        @get("stateManager").transitionTo("subscribing")
  ).observes("state", "id", "channel")

  connect: ->
    @set("sock", new SockJS(@get("url")))
    @set("stateManager", Bridge.SocketManager.create(socket: @))

  reconnect: ->
    @get("sock").close()
