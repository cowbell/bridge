Ember.LOG_VERSION = false
Bridge = window.Bridge = Ember.Application.create()

# Order and include as you please.
require 'scripts/constants'
require 'scripts/controllers/*'
require 'scripts/models/*'
require 'scripts/routes/*'
require 'scripts/views/*'
require 'scripts/router'

# @Bridge = Ember.Application.create()
  # ready: ->
  #   Bridge.env = Bridge.Env.create()
  #   Bridge.session = Bridge.Session.create
  #     userIdBinding: "Bridge.env.userId"
  #     socketIdBinding: "Bridge.env.socketId"
  #     userEmailBinding: "Bridge.env.userEmail"
