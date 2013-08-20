Ember.LOG_VERSION = false

Bridge = window.Bridge = Ember.Application.create
  ready: ->
    Bridge.env = Bridge.Env.create()
    Bridge.session = Bridge.Session.create
      userIdBinding: "Bridge.env.userId"
      socketIdBinding: "Bridge.env.socketId"
      userEmailBinding: "Bridge.env.userEmail"

# Order and include as you please.
require "scripts/constants"
require "scripts/lib/*"
require "scripts/models/*"
require "scripts/views/**/*"
require "scripts/controllers/*"
require "scripts/routes/*"
require "scripts/router"
