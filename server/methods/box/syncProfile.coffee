Meteor.methods(
  syncProfile: ->
    # avoid blocking other method calls from the same client
    this.unblock()
    console.log("Syncing profile with Box...")

    # Determine if token is expired and needs to be refreshed
    tokenExpiration = Meteor.user().services.box.expiresAt
    if Date.now() - tokenExpiration > 0
      Meteor.call("refreshToken")
    else
      console.log("Token valid. Proceed with call to Box API")

    # Get Box access token from User object
    accessToken = Meteor.user().services.box.accessToken

    # Get user Identity (ie. Name, Email, Avatar URL) from Box
    try
      response = HTTP.get(
        "https://www.box.com/api/2.0/users/me",
        {params: {access_token: accessToken}}).data
      identity = response
    catch err
      throw _.extend(new Error("Failed to fetch identity from Box. " + err.message),
        {response: err.response})

    # Get user Role (ie. User, Co-Admin, Admin) from Box
    try
      response = HTTP.get(
        "https://www.box.com/api/2.0/users/me?fields=role",
        {params: {access_token: accessToken}}).data
      role = response
    catch err
      throw _.extend(new Error("Failed to fetch user role from Box. " + err.message),
        {response: err.response})

    # Get user Enterprise information from Box
    try
      response = HTTP.get(
        "https://www.box.com/api/2.0/users/me?fields=enterprise",
        {params: {access_token: accessToken}}).data
      enterprise = response.enterprise
    catch err
      throw _.extend(new Error("Failed to fetch user enterprise from Box. " + err.message),
        {response: err.response})

    # Get user Group membership from Box and build array with Object
    try
      response = HTTP.get(
        "https://www.box.com/api/2.0/users/me/memberships",
        {params: {access_token: accessToken}}).data
      groups = response
    catch err
      throw _.extend(new Error("Failed to fetch group membership from Box. " + err.message),
        {response: err.response})

    Groups = []
    for k, v of groups.entries
      eachGroup = {}
      groupId = v.group.id
      groupName = v.group.name
      eachGroup["id"] = groupId
      eachGroup["name"] = groupName
      Groups.push(eachGroup)


    # Write everything to the user profile
    Meteor.users.update({_id: Meteor.userId()}, {$set: {
      "profile": {fullName: identity.name, avatar: identity.avatar_url, boxRole: role.role, boxTariff: enterprise.type, eid: enterprise.id, boxEntName: enterprise.name, boxGroups: Groups}
    }})

)
