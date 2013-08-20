@Bridge.CONTRACTS = ["1C", "1D", "1H", "1S", "1NT",
                     "2C", "2D", "2H", "2S", "2NT",
                     "3C", "3D", "3H", "3S", "3NT",
                     "4C", "4D", "4H", "4S", "4NT",
                     "5C", "5D", "5H", "5S", "5NT",
                     "6C", "6D", "6H", "6S", "6NT",
                     "7C", "7D", "7H", "7S", "7NT"]

@Bridge.PASS = "PASS"
@Bridge.DOUBLE = "X"
@Bridge.REDOUBLE = "XX"
@Bridge.MODIFIERS = [Bridge.DOUBLE, Bridge.REDOUBLE]
@Bridge.BIDS = Bridge.CONTRACTS.concat(Bridge.MODIFIERS, [Bridge.PASS])

@Bridge.CARDS = ["C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "CT", "CJ", "CQ", "CK", "CA",
                 "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "DT", "DJ", "DQ", "DK", "DA",
                 "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "HT", "HJ", "HQ", "HK", "HA",
                 "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "ST", "SJ", "SQ", "SK", "SA"]

@Bridge.DIRECTIONS = ["N", "E", "S", "W"]
@Bridge.VULNERABILITIES = ["NONE", "NS", "EW", "BOTH"]
@Bridge.SUITS = ["C", "D", "H", "S"]
@Bridge.TRUMPS = Bridge.SUITS.concat("NT")
@Bridge.SIDES = ["NS", "EW"]
