Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    vulnerable = ["NONE", "EW", "NS", "BOTH"][Math.floor(Math.random() * 4)]
    dealer = ["N", "E", "S", "W"][Math.floor(Math.random() * 4)]
    @transitionTo "/boards/2/#{vulnerable}/#{dealer}"
