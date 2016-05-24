Meteor.methods(
  copyTemplate: (items) ->
    # avoid blocking other method calls from the same client
    @unblock()

    check(items, Match.Any)

    userBoxId = Meteor.user().services.box.id
    target = FolderQueue.findOne({boxUserId: userBoxId}, {sort: {addedAt: -1}})
    tokenExpiration = Meteor.user().services.box.expiresAt

    if Date.now() - tokenExpiration > 0
      console.log("Token Expired")
      refreshAccessToken = Meteor.myFunctions.refreshToken()

    # PICK FOLDER TO COPY
    if Meteor.settings.public.environment == "dev"
      targetFolder = "7826540761" #Test folder for Dev
    else if target
      console.log("Found target folder:")
      console.log(" - " + target.folderId)
      console.log(" - " + target.folderName)
      console.log(" - " + target.boxUserId)
      targetFolder = target.folderId
    else
      throw new Meteor.Error(400, "Target folder is unknown. Try launching this window directly by right-clicking on a Box folder.");


    console.log("Copying template for " + Meteor.userId() + " (userId) to " + targetFolder + " (" + target.folderName + ")...")

    itemsStatus = []

    items.forEach (item) ->
      id = item.id
      name = item.name
      type = item.type
      console.log(id + ", " + name + ", " + type)

      if type == "folder"
        try
          apiURL = "https://api.box.com/2.0/folders/" + id + "/copy"
          accessToken = Meteor.user().services.box.accessToken
          response = HTTP.post(apiURL, {
            params: {access_token: accessToken},
            data: {
              "parent": {
                "id" : targetFolder
              },
              "name": name
            }
          })

          itemStatus = {}
          itemStatus["type"] = "success"
          itemStatus["name"] = name
          itemStatus["message"] = "successfully created"
          itemsStatus.push(itemStatus)
          console.log("Success! " + response.data.name + " created")

        catch error
          itemStatus = {}
          itemStatus["type"] = "error"
          itemStatus["name"] = name
          itemStatus["message"] = error.response.data.message
          itemsStatus.push(itemStatus)
      else
        try
          apiURL = "https://api.box.com/2.0/files/" + id + "/copy"
          accessToken = Meteor.user().services.box.accessToken
          response = HTTP.post(apiURL, {
            params: {access_token: accessToken},
            data: {
              "parent": {
                "id" : targetFolder
              },
              "name": name
            }
          })

          itemStatus = {}
          itemStatus["type"] = "success"
          itemStatus["name"] = name
          itemStatus["message"] = "successfully created"
          itemsStatus.push(itemStatus)
          console.log("Success! " + response.data.name + " created")

        catch error
          itemStatus = {}
          itemStatus["type"] = "error"
          itemStatus["name"] = name
          itemStatus["message"] = error.response.data.message
          itemsStatus.push(itemStatus)
    console.log(itemsStatus.toString())
    return itemsStatus

)
