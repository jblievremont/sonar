define [
  'backbone'
], (
  Backbone
) ->

  class extends Backbone.Model

    defaults:
      page: 1
      orderBy: 'UPDATE_DATE'
      orderAsc: false


    nextPage: ->
      page = @get 'page'
      @set page: page + 1

