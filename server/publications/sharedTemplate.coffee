Meteor.publish 'sharedTemplate', ->
  user = Meteor.users.findOne(this.userId)
  Template.find({ 
    $and: [ 
      { "sharing.shared": true }, 
      $or: [
        { "sharing.eid": user.profile.eid } 
      ]
    ] 
  })