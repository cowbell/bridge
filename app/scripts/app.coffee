Ember.LOG_VERSION = false

Bridge = window.Bridge = Ember.Application.create()

# Order and include as you please.
require "scripts/constants"
require "scripts/lib/*"
require "scripts/models/*"
require "scripts/views/**/*"
require "scripts/controllers/*"
require "scripts/routes/*"
require "scripts/router"
