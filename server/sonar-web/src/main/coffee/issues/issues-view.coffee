define [
  'backbone.marionette'
  'issues/issue-view'
], (
  Marionette
  IssueView
) ->


  class extends Marionette.CollectionView
    tagName: 'ul'
    itemView: IssueView


    itemViewOptions: ->
      app: @options.app
