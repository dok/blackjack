class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @canHit = true
    @blackJack = false

    # if array[0].value + array[1].value is 21
    if @bestScore() is 21
      # console.log('wattt')
      @blackJack = true
      @canHit = false
    return

  hit: ->
    @add(@deck.pop()).last() if @canHit
    if @bestScore() > 21
      @canHit = false
      @trigger 'bust', @

  stand: ->
    @canHit = false
    # trigger the stand event
    @trigger 'stand', @

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  bestScore: ->
    21
