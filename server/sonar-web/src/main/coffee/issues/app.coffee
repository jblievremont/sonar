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
  'issues/workspace-list-view'
  'issues/workspace-header-view'

  'common/handlebars-extensions'
], (
  Backbone, Marionette

  State
  Layout
  Issues
  WorkspaceListView
  WorkspaceHeaderView
) ->

  $ = jQuery
  App = new Marionette.Application


  App.addInitializer ->
    @layout = new Layout()
    $('.issues').empty().append @layout.render().el


  App.addInitializer ->
    @state = new State()
    @state.on 'change:orderBy', => @fetchIssues()
    @state.on 'change:orderAsc', => @fetchIssues()
    @issues = new Issues()


  App.addInitializer ->
    @issuesView = new WorkspaceListView
      app: @
      collection: @issues
    @layout.workspaceListRegion.show @issuesView


  App.addInitializer ->
    @workspaceHeaderView = new WorkspaceHeaderView
      app: @
      collection: @issues
    @layout.workspaceHeaderRegion.show @workspaceHeaderView


  App.addInitializer ->
    @fetchIssues()


  App.fetchIssues = (remove = true) ->
    data =
      p: @state.get 'page'
      ps: 200
      resolved: false
      severities: 'MINOR'
      extra_fields: 'actions,transitions,assigneeName,reporterName,actionPlanName'
      s: @state.get 'orderBy'
      asc: @state.get 'orderAsc'
    @issues.fetch
      remove: remove
      data: data


  App.fetchNextPage = ->
    @state.nextPage()
    @fetchIssues false


  l10nXHR = window.requestMessages()
  jQuery.when(l10nXHR).done -> App.start()
