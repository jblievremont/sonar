requirejs.config
  baseUrl: "#{baseUrl}/js"

  paths:
    'backbone': 'third-party/backbone'
    'backbone.marionette': 'third-party/backbone.marionette'
    'handlebars': 'third-party/handlebars'

  shim:
    'backbone.marionette':
      deps: ['backbone']
      exports: 'Marionette'
    'backbone':
      exports: 'Backbone'
    'handlebars':
      exports: 'Handlebars'


requirejs [
  'backbone', 'backbone.marionette'

  'issues/state'
  'issues/layout'
  'issue/collections/issues'
  'issues/issues-view'

  'common/handlebars-extensions'
], (
  Backbone, Marionette

  State
  Layout
  Issues
  IssuesView
) ->

  $ = jQuery
  App = new Marionette.Application


  App.addInitializer ->
    @layout = new Layout()
    $('.issues').empty().append @layout.render().el


  App.addInitializer ->
    @state = new State()


  App.addInitializer ->
    @issues = new Issues()
    @issuesView = new IssuesView
      app: @
      collection: @issues
    @layout.workspaceRegion.show @issuesView
    @fetchIssues()


  App.fetchIssues = ->
    data =
      ps: 20
      resolved: false
      extra_fields: 'actions,transitions,assigneeName,reporterName,actionPlanName'
      s: @state.get 'orderBy'
      asc: @state.get 'orderAsc'
    @issues.fetch
      data: data


  l10nXHR = window.requestMessages()
  jQuery.when(l10nXHR).done -> App.start()
