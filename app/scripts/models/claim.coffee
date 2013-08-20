@Bridge.Claim = Ember.Object.extend
  save: (boardId) ->
    $.ajax "/api/boards/#{boardId}/claims",
      type: "post"
      data: claim: @getProperties("direction", "tricks")

  accept: (boardId, direction) ->
    $.ajax "/api/boards/#{boardId}/claims/#{@get('id')}/accept",
      type: "patch"
      data: claim: {accepted: direction}

  reject: (boardId, direction) ->
    $.ajax "/api/boards/#{boardId}/claims/#{@get('id')}/reject",
      type: "patch"
      data: claim: {rejected: direction}
