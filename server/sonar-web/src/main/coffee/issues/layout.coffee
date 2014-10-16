define [
  'backbone.marionette'
  'templates/issues'
], (
  Marionette
  Templates
) ->

  class extends Marionette.Layout
    template: Templates['issues-layout']


    regions:
      facetsRegion: '.issues-facets'
      workspaceHeaderRegion: '.issues-workspace-header'
      workspaceListRegion: '.issues-workspace-list'


    showSpinner: (region) ->
      @[region].show new Marionette.ItemView
        template: _.template('<i class="spinner"></i>')
