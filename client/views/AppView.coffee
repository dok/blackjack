class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.get('playerHand').on 'stand', =>
      #   run the dealer
      #   if dealer's hand is
      do @model.playDealer
      do @model.scoreGame

    @model.on 'playerWins', =>
      alert 'PLAYER WINS'

    @model.on 'dealerWins', =>
      alert 'DEALER WINS'

    @model.get('playerHand').on 'bust', =>
      alert 'BUST: DEALER WINSSS'

    @model.get('dealerHand').on 'bust', =>
      alert 'BUST: PLAYA WINSSS'

    if @model.get 'blackJack'
      alert 'BLACK JACK'

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
