Meteor.methods(
  copyTemplate: (folder, targetFolderName) ->
    check(folder, Match.Any)
    check(targetFolderName, Match.Any)

    sourceFolder = folder
    userBoxId = Meteor.user().services.box.id
    target = FolderQueue.findOne({boxUserId: userBoxId}, {sort: {addedAt: -1}})
    tokenExpiration = Meteor.user().services.box.expiresAt

    if Date.now() - tokenExpiration > 0
      console.log("Token Expired")
      refreshAccessToken = Meteor.myFunctions.refreshToken()

    # PICK FOLDER TO COPY
    if Meteor.settings.public.environment == "dev"
      targetFolder = "0" #Root level for Dev
    else if target
      console.log("Found target folder:")
      console.log(" - " + target.folderId)
      console.log(" - " + target.folderName)
      console.log(" - " + target.boxUserId)
      targetFolder = target.folderId
    else
      throw new Meteor.Error(400, "Target folder is unknown. Try launching this window directly by right-clicking on a Box folder.");


    console.log("Copying template for " + Meteor.userId() + " (userId) from " + sourceFolder + " (Box folder ID) to " + targetFolder + " (" + target.folderName + ")...")



    apiURL = "https://api.box.com/2.0/folders/" + sourceFolder + "/copy"

    try
      accessToken = Meteor.user().services.box.accessToken
      response = HTTP.post(apiURL, {
        params: {access_token: accessToken},
        data: {
          "parent": {
            "id" : targetFolder
          },
          "name": targetFolderName
        }
      })

      if response.data.error # if the http response was a json object with an error attribute
        throw new Error("Failed to create from Template: " + response.data.error)
      else
        console.log("Success! " + response.data.name + " created")

      return response.data
    catch error
      throw new Meteor.Error(500, error.response.data.message)

)
