Meteor.publish 'UserData', ->
  Meteor.users.find({_id: this.userId})
