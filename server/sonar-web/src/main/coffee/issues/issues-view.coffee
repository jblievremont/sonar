define [
  'backbone.marionette'
  'templates/issues'
  'issues/issue-view'
], (
  Marionette
  Templates
  IssueView
) ->

  class extends Marionette.CompositeView
    template: Templates['issues-issues']
    itemViewContainer: '.issue-list'
    itemView: IssueView


    itemViewOptions: ->
      app: @options.app


    collectionEvents:
      'all': 'updateHeader'


    updateHeader: ->
      @$('.js-issues-total').text @collection.paging?.fTotal
      @$('.js-issues-debt-total').text '3d 7h'


    serializeData: ->
      _.extend super,
        state: @options.app.state.toJSON()
        orderBy: @options.app.state.get('orderBy').toLowerCase()

