# Requires bigInt library
# https://github.com/peterolson/BigInteger.js

@Bridge.Deal = class Deal
  @MAX: bigInt("53644737765488792839237440000")

  @random: ->
    dealer = Bridge.DIRECTIONS[Math.floor(Math.random() * 4)]
    vulnerable = Bridge.VULNERABILITIES[Math.floor(Math.random() * 4)]
    # TODO: investigate randomness
    until id?.lesserOrEquals(Bridge.Deal.MAX)
      part = ""
      part += Math.floor(Math.random() * 9) for i in [0..28]
      id = bigInt(part)

    new Bridge.Deal(id, dealer, vulnerable)

  constructor: (id, dealer, vulnerable) ->
    @id = bigInt(id)
    @dealer = dealer
    @vulnerable = vulnerable

  isValid: ->
    Bridge.DIRECTIONS.indexOf(@dealer)? and
    Bridge.VULNERABILITIES.indexOf(@vulnerable)? and
    @id?.greaterOrEquals(0) and @id.lesserOrEquals(@constructor.MAX)

  n: ->
    @_n or @dealCards().n
  e: ->
    @_e or @dealCards().e
  s: ->
    @_s or @dealCards().s
  w: ->
    @_w or @dealCards().w

  dealCards: ->
    @_n = []
    @_e = []
    @_s = []
    @_w = []
    k = @constructor.MAX
    id = @id

    Bridge.CARDS.forEach (card, i) =>
      x = k.multiply(13 - @_n.length).divide(52 - i)
      if id.lesser(x)
        @_n.push(card)
      else
        id = id.subtract(x)
        x = k.multiply(13 - @_e.length).divide(52 - i)
        if id.lesser(x)
          @_e.push(card)
        else
          id = id.subtract(x)
          x = k.multiply(13 - @_s.length).divide(52 - i)
          if id.lesser(x)
            @_s.push(card)
          else
            id = id.subtract(x)
            x = k.multiply(13 - @_w.length).divide(52 - i)
            @_w.push(card)
      k = x

    n: @_n
    e: @_e
    s: @_s
    w: @_w
