Router.map ->

  @route 'home',
    path: '/'
    layoutTemplate: 'homeLayout'
    waitOn: ->
      Meteor.subscribe 'Template'
      Meteor.subscribe 'sharedTemplate'
      Meteor.subscribe 'FolderQueue'
      Meteor.subscribe 'UserData'
    data: ->
      userId = Meteor.userId()
      privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {name: 1}})
      sharedTemplates: Template.find({owner: { $ne: userId }, "sharing.shared": true}, {sort: {name: 1}})
      queue: FolderQueue.findOne({}, {sort: {addedAt: -1}})
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/')
      Meteor.call("syncProfile")
      @next()


  @route 'profile',
    path: '/profile'
    layoutTemplate: 'basicLayout'
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/profile')
      Meteor.call("syncProfile")
      @next()


  @route 'signOut',
    path: '/logout'
    onBeforeAction: ->
      AccountsTemplates.logout()
      @redirect '/'
      @next()


  @route 'staleSession',
    path: '/stalesession'
    layoutTemplate: 'accountsLayout'
