Router.map ->

  @route 'home',
    path: '/'
    layoutTemplate: 'homeLayout'
    waitOn: ->
      Meteor.subscribe 'Template'
    data: ->
      privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {name: 1}})
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
