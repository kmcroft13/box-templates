Router.map ->

  @route 'server',
    path: '/server'
    where: 'server'
    action: ->
      folderId = this.request.body.file_id
      folderName = this.request.body.file_name
      userId = this.request.body.box_id

      check(folderId, Match.Any)
      check(folderName, Match.Any)
      check(userId, Match.Any)

      FolderQueue.insert(
        {
          folderName: folderName,
          folderId: folderId,
          boxUserId: userId,
          addedAt: new Date()
        }
      )

      this.response.statusCode = 200;
      console.log("Folder successfully submitted to queue.")
      this.response.end("Folder successfully submitted to queue.")
