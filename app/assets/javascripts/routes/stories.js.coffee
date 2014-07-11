App.StoriesRoute = Ember.Route.extend
  model: ->
    @get('store').findAll('story')