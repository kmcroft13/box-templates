Router.map ->

  @route 'folderqueue',
    path: '/folderqueue'
    where: 'server'
    action: ->
      folderId = this.request.body.folder_id
      folderName = this.request.body.folder_name
      userId = this.request.body.box_id
      Meteor.call('controllerFolderQueue', folderId, folderName, userId)
