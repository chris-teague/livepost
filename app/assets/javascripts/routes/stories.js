App.StoriesRoute = Ember.Route.extend({
  activate: function() {

    // var self = this;
    // var client = new Faye.Client("/faye", {
    //   retry: 5,
    //   timeout: 120
    // });

    // client.subscribe("/stories", function(message) {
    //   if (message.type === "created" || message.type === "updated") {
    //     self.store.find('story', JSON.parse(message.data).id).then(function(story) {
    //       story.reload();
    //     });
    //   } else if (message.type === "deleted") {
    //     self.store.find('story', JSON.parse(message.data).id).then(function(story) {
    //       story.deleteRecord();
    //     });
    //   }
    // });

  },
  model: function() { 
    return this.store.find('story');
  }
});


App.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller, model) {

    var store = this.get('store');
    var client = new Faye.Client("/faye", {
      retry: 5,
      timeout: 120
    });

    client.subscribe("/stories", function(message) {
      console.log(message);
      store.push('story', JSON.parse(message.data));
    });

  }
});