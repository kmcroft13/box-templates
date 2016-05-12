Router.map ->

  @route 'folderqueue',
    path: '/folderqueue'
    where: 'server'
    action: ->
      folderId = this.request.body.folder_id
      folderName = this.request.body.folder_name
      userId = this.request.body.box_id

      check(folderId, Match.Any)
      check(folderName, Match.Any)
      check(userId, Match.Any)

      status = 0
      response = ""

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
