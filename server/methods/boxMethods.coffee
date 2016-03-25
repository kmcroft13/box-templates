Meteor.methods(
  copyTemplate: (folder) ->
    check(folder, Match.Any)
    # avoid blocking other method calls from the same client
    this.unblock()
    sourceFolder = folder

    #PICK FOLDER TO COPY
    if Meteor.settings.public.environment == "dev"
      targetFolder = "0" #Root level for Dev
    else if targetFolder
      targetFolder = targetFolder
    else
      throw new Meteor.Error(400, "Target folder is unknown");


    console.log("Copying template for " + Meteor.userId() + " (userId) from " + sourceFolder + " (Box folder ID) to " + targetFolder + " (Box folder ID)...")

    tokenExpiration = Meteor.user().services.box.expiresAt
    if Date.now() - tokenExpiration > 0
      console.log("Token Expired")
      config = ServiceConfiguration.configurations.findOne({service: 'box'})
      if !config
        throw new ServiceConfiguration.ConfigError()

      console.log("Trying to exchange Refresh Token...")
      this.unblock()
      refreshToken = Meteor.user().services.box.refreshToken
      console.log(refreshToken)

      apiUrl = "https://app.box.com/api/oauth2/token"
      result = HTTP.post( apiUrl, {
          params: {
              client_id: config.appId,
              client_secret: config.secret,
              refresh_token: refreshToken,
              grant_type: 'refresh_token'
          }
      })

      if result.data.access_token
        Meteor.users.update({_id: Meteor.userId()}, {$set: {
          'services.box.accessToken': result.data.access_token,
          'services.box.expiresAt': result.data.expires_in,
          'services.box.refreshToken': result.data.refresh_token
        }})

        console.log("Success! New access token...")
        console.log(result.data.access_token)
        console.log("Proceeding with call to Box API")
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
          "name": "TEST"
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
