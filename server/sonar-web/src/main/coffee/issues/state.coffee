define [
  'backbone'
], (
  Backbone
) ->

  class extends Backbone.Model

    defaults:
      orderBy: 'UPDATE_DATE'
      orderAsc: false

