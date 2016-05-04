Meteor.publish 'FolderQueue', ->
  if this.userId
    user = Meteor.users.findOne(this.userId)
    userBoxId = user.services.box.id

  FolderQueue.find({boxUserId: userBoxId})
