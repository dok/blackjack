#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  playDealer: ->
    do @get('dealerHand').at(0).flip
    score = do @get('dealerHand').bestScore
    while score < 17
      do @get('dealerHand').hit
      score = do @get('dealerHand').bestScore

  scoreGame: ->
    playerScore = do @get('playerHand').bestScore
    dealerScore = do @get('dealerHand').bestScore
    console.log playerScore, dealerScore
    if playerScore <= 21 and (playerScore > dealerScore or dealerScore > 21)
      @trigger 'playerWins'
    else
      @trigger 'dealerWins'
