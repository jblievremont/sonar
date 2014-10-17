define [
  'backbone.marionette'
  'templates/issues'
  'issues/issue-view'
], (
  Marionette
  Templates
  IssueView
) ->

  $ = jQuery


  class extends Marionette.CompositeView
    template: Templates['issues-workspace-list']
    itemView: IssueView
    itemViewContainer: 'ul'


    ui:
      loadMore: '.js-issues-more'


    collectionEvents:
      'sync': 'bindScrollEvents'


    itemViewOptions: ->
      app: @options.app


    initialize: ->
      @loadMoreThrottled = _.throttle @loadMore, 1000


    onClose: ->
      $(window).off 'scroll.issues-workspace-list'


    bindScrollEvents: ->
      $(window).on 'scroll.issues-workspace-list', (=> @onScroll())
      @ui.loadMore.toggle !@collection.paging.maxResultsReached


    loadMore: ->
      $(window).off 'scroll.issues-workspace-list'
      unless @collection.paging.maxResultsReached
        @options.app.fetchNextPage()


    onScroll: ->
      if $(window).scrollTop() + $(window).height() >= @ui.loadMore.offset().top
        @loadMoreThrottled()


    serializeData: ->
      _.extend super,
        paging: @collection.paging
