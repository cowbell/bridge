@Bridge.SocketController = Ember.ObjectController.extend
  init: ->
    @set "content", Bridge.Socket.create
      controller: @
      urlBinding: "Bridge.env.socketUrl"
      idBinding: "Bridge.env.socketId"
      channelBinding: "controller.channel"
