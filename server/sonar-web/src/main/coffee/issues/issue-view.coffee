define [
  'backbone.marionette'
  'templates/issues'
  'issue/issue-view'
], (
  Marionette
  Templates
  IssueBoxView
) ->

  class extends Marionette.ItemView
    tagName: 'li'
    className: 'issue-box'
    template: Templates['issues-issue']


    onRender: ->
      @issueBoxView = new IssueBoxView model: @model
      @$('.issue-box-details').append @issueBoxView.render().el


    onClose: ->
      @issueBoxView?.close()
