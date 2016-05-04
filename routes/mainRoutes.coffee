Router.map ->

  @route 'home',
    path: '/'
    onBeforeAction: ->
      if Meteor.userId()
        Meteor.call("syncProfile")
        @next()
      else
        @next()

  @route 'profile',
    path: '/profile'
    layout: 'basicLayout'
    onBeforeAction: ->
      if Meteor.userId()
        Meteor.call("syncProfile")
        @next()
      else
        @next()

  @route 'signOut',
    path: '/sign-out'
    onBeforeAction: ->
      AccountsTemplates.logout()
      @redirect '/'
      @next()
