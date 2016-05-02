Meteor.methods(
  copyTemplate: (folder, targetFolderName) ->
    check(folder, Match.Any)
    check(targetFolderName, Match.Any)
    # avoid blocking other method calls from the same client
    this.unblock()
    sourceFolder = folder
    userBoxId = Meteor.user().services.box.id

    #PICK FOLDER TO COPY
    if Meteor.settings.public.environment == "dev"
      targetFolder = "0" #Root level for Dev
    else if targetFolder
      targetFolder = FolderQueue.findOne({boxUserId: userBoxId}, {sort: {DateTime: -1}})
      console.log(targetFolder)
    else
      throw new Meteor.Error(400, "Target folder is unknown. Try launching this window directly by right-clicking on a Box folder.");


    console.log("Copying template for " + Meteor.userId() + " (userId) from " + sourceFolder + " (Box folder ID) to " + targetFolder + " (Box folder ID)...")

    tokenExpiration = Meteor.user().services.box.expiresAt
    if Date.now() - tokenExpiration > 0
      Meteor.call("refreshToken")
    else
      console.log("Token valid. Proceed with call to Box API")

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
