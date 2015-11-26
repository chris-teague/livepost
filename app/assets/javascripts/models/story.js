App.Story = DS.Model.extend({
  name: DS.attr('string'),
  body: DS.attr('string'),
  comments: DS.hasMany('comment', { async: true })
})