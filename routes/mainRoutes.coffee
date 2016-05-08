Router.map ->

  @route 'home',
    path: '/'
    onBeforeAction: ->
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()
      

  @route 'profile',
    path: '/profile'
    layout: 'basicLayout'
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
