# require("test_helper")
# require("models/bid")
describe "Bid", ->
  describe "isContract", ->
    it "returns true for 1NT", ->
      bid = Bridge.Bid.create content: "1NT"
      assert.isTrue bid.get("isContract")

    it "returns false for PASS", ->
      bid = Bridge.Bid.create content: "PASS"
      assert.isFalse bid.get("isContract")

  describe "isDouble", ->
    it "returns true for X", ->
      bid = Bridge.Bid.create content: "X"
      assert.isTrue bid.get("isDouble")

    it "returns false for PASS", ->
      bid = Bridge.Bid.create content: "PASS"
      assert.isFalse bid.get("isDouble")

  describe "isRedouble", ->
    it "returns true for XX", ->
      bid = Bridge.Bid.create content: "XX"
      assert.isTrue bid.get("isRedouble")

    it "returns false for 1S", ->
      bid = Bridge.Bid.create content: "1S"
      assert.isFalse bid.get("isRedouble")

  describe "isModifier", ->
    it "returns true for XX", ->
      bid = Bridge.Bid.create content: "XX"
      assert.isTrue bid.get("isModifier")

    it "returns false for PASS", ->
      bid = Bridge.Bid.create content: "PASS"
      assert.isFalse bid.get("isModifier")

  describe "isPass", ->
    it "returns true for PASS", ->
      bid = Bridge.Bid.create content: "PASS"
      assert.isTrue bid.get("isPass")

    it "returns false for X", ->
      bid = Bridge.Bid.create content: "X"
      assert.isFalse bid.get("isPass")

  describe "level", ->
    it "returns 2 for 2H", ->
      bid = Bridge.Bid.create content: "2H"
      assert.strictEqual bid.get("level"), 2

    it "returns undefined for PASS", ->
      bid = Bridge.Bid.create content: "PASS"
      assert.strictEqual bid.get("level"), undefined

  describe "trump", ->
    it "returns NT for 2NT", ->
      bid = Bridge.Bid.create content: "2NT"
      assert.strictEqual bid.get("trump"), "NT"

    it "returns undefined for PASS", ->
      bid = Bridge.Bid.create content: "PASS"
      assert.strictEqual bid.get("trump"), undefined

  describe "compact", ->
    it "splits compact to content and alert", ->
      bid = Bridge.Bid.create compact: "2D!wilkosz"
      assert.strictEqual bid.get("content"), "2D"
      assert.strictEqual bid.get("alert"), "wilkosz"

    it "splits compact to content and alert when no description", ->
      bid = Bridge.Bid.create compact: "2D!"
      assert.strictEqual bid.get("content"), "2D"
      assert.strictEqual bid.get("alert"), ""

    it "sets content to bid and alert to undefined", ->
      bid = Bridge.Bid.create compact: "2D"
      assert.strictEqual bid.get("content"), "2D"
      assert.isUndefined bid.get("alert")

    it "joins content and alert", ->
      bid = Bridge.Bid.create content: "2D", alert: "wilkosz"
      assert.strictEqual bid.get("compact"), "2D!wilkosz"

    it "joins content and alert when no description", ->
      bid = Bridge.Bid.create content: "2D", alert: ""
      assert.strictEqual bid.get("compact"), "2D!"

    it "returns content when no alert", ->
      bid = Bridge.Bid.create content: "2D", alert: undefined
      assert.strictEqual bid.get("compact"), "2D"
