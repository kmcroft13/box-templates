Meteor.publish 'UserData', ->
  Meteor.users.find({_id: this.userId}, {fields: {'services.box.expiresAt': 1}})

Meteor.publish 'UserProfiles', ->
  currentUser = Meteor.users.findOne({_id: this.userId})
  Meteor.users.find({"profile.eid": currentUser.profile.eid}, {fields: {'profile.fullName': 1}})
