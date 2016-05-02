Meteor.publish 'Template', ->
  Template.find({owner: this.userId})
