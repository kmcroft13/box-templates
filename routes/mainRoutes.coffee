Router.map ->

  @route 'home',
    path: '/'
    layoutTemplate: 'homeLayout'
    onBeforeAction: ->
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()


  @route 'profile',
    path: '/profile'
    layoutTemplate: 'basicLayout'
    onBeforeAction: ->
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()


  @route 'signOut',
    path: '/sign-out'
    onBeforeAction: ->
      AccountsTemplates.logout()
      @redirect '/'
      @next()
