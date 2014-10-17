define [
  'backbone.marionette'
  'templates/issues'
  'issues/issue-view'
], (
  Marionette
  Templates
  IssueBoxView
) ->

  class extends Marionette.ItemView
    tagName: 'li'
    className: 'issue-box'
    template: Templates['issues-workspace-list-item']


    onRender: ->
      @issueBoxView = new IssueBoxView model: @model
      @$('.issue-box-details').append @issueBoxView.render().el


    onClose: ->
      @issueBoxView?.close()
