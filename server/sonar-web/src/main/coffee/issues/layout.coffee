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
      workspaceRegion: '.issues-workspace'


    showSpinner: (region) ->
      @[region].show new Marionette.ItemView
        template: _.template('<i class="spinner"></i>')
