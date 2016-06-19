Meteor.methods(
  controllerFolderQueue: (folderId, folderName, userId) ->

    check(folderId, Match.Any)
    check(folderName, Match.Any)
    check(userId, Match.Any)

    status = 0
    response = ""

    # remove all previous entries for this user in the queue
    FolderQueue.remove(
      {
        boxUserId: userId
      }
    )

    # insert new entry for this user
    FolderQueue.insert(
      {
        folderName: folderName,
        folderId: folderId,
        boxUserId: userId,
        addedAt: new Date()
      }, (error, result) ->
        if error
           console.log("Nothing added to queue: " + error)
           status = 400
           response = "Bad request"
        else
           console.log("Folder successfully submitted to queue: " + result)
           status = 200
           response = "Folder successfully submitted to queue."
    )

    this.response.statusCode = status
    this.response.end(response)
)
