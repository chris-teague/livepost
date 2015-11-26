App.Comment = DS.Model.extend
  comment: DS.attr('string')
  story: DS.belongsTo('story')
