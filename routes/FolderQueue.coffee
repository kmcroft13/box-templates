Router.map ->

  @route 'folderqueue',
    path: '/folderqueue'
    where: 'server'
    action: ->
      console.log("Begin controllerFolderQueue...")
      folderId = this.request.body.folder_id
      folderName = this.request.body.folder_name
      userId = this.request.body.box_id
      status = 404
      response = "An error occured"
      Meteor.call('controllerFolderQueue', folderId, folderName, userId, (error, result) ->
        if error
           console.log("Error. Nothing added to queue. " + error)
           status = 400
           response = "" + error + ""
        else
           console.log("Success! Folder submitted to queue: " + result)
           status = 200
           response = "Folder submitted to queue: " + result
      )
      this.response.statusCode = status
      this.response.end(response)
