Bridge.TableRoute = Ember.Route.extend
  model: (params) ->
    # TODO: get cards from board id
    Bridge.Table.create
      board:
        id: params.board_id
        dealer: params.dealer?.toUpperCase()
        vulnerable: params.vulnerable?.toUpperCase()
        bids: []
        cards: []
        n: ["SQ", "ST", "S6", "S3", "H7", "DK", "DT", "D3", "D2", "CQ", "C9", "C7", "C3"]
        e: ["SA", "SK", "SJ", "S8", "DA", "DJ", "D7", "D6", "CA", "CT", "C8", "C5", "C4"]
        s: ["S9", "S7", "S5", "S2", "HA", "H8", "H3", "DQ", "D8", "D5", "D4", "C6", "C2"]
        w: ["S4", "HK", "HQ", "HJ", "HT", "H9", "H6", "H5", "H4", "H2", "D9", "CK", "CJ"]
        result: null
        claim: null

  serialize: (model) ->
    board_id:   model.get("board.id")
    vulnerable: model.get("board.vulnerable")
    dealer:     model.get("board.dealer")
