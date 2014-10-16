define [
  'backbone.marionette'
  'templates/issues'
  'common/popup'
], (
  Marionette
  Templates
  Popup
) ->

  $ = jQuery


  class extends Popup
    template: Templates['issues-order-choices']


    events:
      'click a': 'sort'


    sort: (e) ->
      @options.app.state.set
        orderBy: $(e.currentTarget).data 'sort'
        orderAsc: $(e.currentTarget).data 'asc'
