Bridge.TableRoute = Ember.Route.extend
  model: (params) ->
    deal = new Bridge.Deal(params.board_id, params.dealer?.toUpperCase(), params.vulnerable?.toUpperCase())
    throw "Invalid deal" unless deal.isValid()
    Bridge.Table.create
      board:
        id: deal.id.toString()
        dealer: deal.dealer
        vulnerable: deal.vulnerable
        bids: []
        cards: []
        n: deal.n()
        e: deal.e()
        s: deal.s()
        w: deal.w()

  serialize: (model) ->
    board_id:   model.get("board.id")
    vulnerable: model.get("board.vulnerable")
    dealer:     model.get("board.dealer")
