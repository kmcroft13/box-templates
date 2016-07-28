Meteor.myFunctions = (
  refreshToken: ->
    config = ServiceConfiguration.configurations.findOne({service: 'box'})
    if !config
      throw new ServiceConfiguration.ConfigError()

    console.log("Trying to exchange Refresh Token...")

    refreshToken = Meteor.user().services.box.refreshToken
    console.log(refreshToken)

    apiUrl = "https://api.box.com/oauth2/token"
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
        'services.box.expiresAt': (+new Date) + (1000 * result.data.expires_in),
        'services.box.refreshToken': result.data.refresh_token
      }})

      console.log("Success! New access token...")
      console.log(result.data.access_token)
      console.log("Proceeding with call to Box API")
)
