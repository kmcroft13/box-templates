Router.map ->

  @route 'home',
    path: '/'
    layoutTemplate: 'homeLayout'
    waitOn: ->
      Meteor.subscribe 'Template'
      Meteor.subscribe 'FolderQueue'
    data: ->
      privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {name: 1}})
      queue: FolderQueue.findOne({}, {sort: {addedAt: -1}})
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/')
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()


  @route 'newHome',
    path: '/new'
    layoutTemplate: 'homeLayout'
    waitOn: ->
      Meteor.subscribe 'Template'
      Meteor.subscribe 'FolderQueue'
    data: ->
      privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {name: 1}})
      queue: FolderQueue.findOne({}, {sort: {addedAt: -1}})
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/')
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()


  @route 'profile',
    path: '/profile'
    layoutTemplate: 'basicLayout'
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/profile')
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()


  @route 'signOut',
    path: '/sign-out'
    onBeforeAction: ->
      AccountsTemplates.logout()
      @redirect '/'
      @next()
