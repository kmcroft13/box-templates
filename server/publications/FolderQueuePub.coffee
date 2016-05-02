Meteor.publish 'FolderQueue', ->
  user = Meteor.users.findOne(this.userId)
  userBoxId = user.services.box.id
  
  FolderQueue.find({boxUserId: userBoxId})
