#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  playDealer: ->
    do @get('dealerHand').at(0).flip
    possibleScores = do @get('dealerHand').scores
    score = @bestScore possibleScores
    while score < 17
      do @get('dealerHand').hit
      possibleScores = do @get('dealerHand').scores
      score = @bestScore possibleScores

  bestScore: (possibleScores) ->
    possibleScores[0]
