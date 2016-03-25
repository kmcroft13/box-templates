Meteor.methods(
  refreshToken: ->

    console.log("Does it get here?")

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
)
