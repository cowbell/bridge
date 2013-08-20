Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "/tables/2"
