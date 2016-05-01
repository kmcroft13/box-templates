Router.map ->

  @route 'server',
    path: '/server'
    where: 'server'
    action: ->
      console.log("this.params: ", this.params)
      console.log("this.request.body: ", this.request.body)
      console.log("this.request.query: ", this.request.query)

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
          boxUserId: userId
        }
      )

      this.response.statusCode = 200;
      this.response.end("Folder successfully submitted to queue.");
