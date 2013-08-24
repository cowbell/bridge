Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    deal = Bridge.Deal.random()
    @transitionTo "/boards/#{deal.id.toString()}/#{deal.vulnerable}/#{deal.dealer}"
