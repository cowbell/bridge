@Bridge.BidView = Ember.View.extend
  classNames: ["hint--top", "hint--rounded"]
  classNameBindings: ["isAlerted:bid-alerted"]
  attributeBindings: ["alertBody:data-hint"]
  templateName: "bid"
  tagName: "td"

  content: (->
    switch
      when @get("bid.isPass")     then "Pass"
      when @get("bid.isDouble")   then "Dbl"
      when @get("bid.isReDduble") then "Rdbl"
      when @get("bid.isContract")
        switch @get("bid.trump")
          when "C" then @get("bid.level") + "<span class='suit-c'>♣</span>"
          when "D" then @get("bid.level") + "<span class='suit-d'>♦</span>"
          when "H" then @get("bid.level") + "<span class='suit-h'>♥</span>"
          when "S" then @get("bid.level") + "<span class='suit-s'>♠</span>"
          else
            @get("bid.content")
  ).property("bid.content")

  isAlerted: (->
    !Ember.isNone(@get("bid.alert"))
  ).property("bid.alert")

  alertBody: (->
    if Ember.isEmpty(@get("bid.alert")) then false else @get("bid.alert")
  ).property("bid.alert")
