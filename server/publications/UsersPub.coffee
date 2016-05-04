Meteor.publish 'UserData', ->
  Meteor.users.find({_id: this.userId}, {fields: {'services.box.expiresAt': 1}})
