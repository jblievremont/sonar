define [
  'backbone.marionette'
  'templates/issues'
  'issues/order-choices-popup'
], (
  Marionette
  Templates
  OrderChoicesPopup
) ->

  $ = jQuery


  class extends Marionette.ItemView
    template: Templates['issues-workspace-header']


    collectionEvents:
      'all': 'render'


    events:
      'click .js-issues-order': 'showOrderChoices'


    initialize: (options) ->
      @listenTo options.app.state, 'change', @render


    showOrderChoices: (e) ->
      e.stopPropagation()
      $('body').click()
      @orderChoicesPopup = new OrderChoicesPopup
        app: @options.app
        triggerEl: @$('.js-issues-order')
        bottom: true
      @orderChoicesPopup.render()


    serializeData: ->
      _.extend super,
        state: @options.app.state.toJSON()
        paging: @collection.paging
        orderBy: @options.app.state.get('orderBy').toLowerCase()

