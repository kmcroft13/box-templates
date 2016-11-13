Router.map ->

  @route 'templates',
    path: '/templates'
    waitOn: ->
      Meteor.subscribe 'Template'
      Meteor.subscribe 'sharedTemplate'
      Meteor.subscribe 'FolderQueue'
      Meteor.subscribe 'UserData'
    data: ->
      userId = Meteor.userId()
      privateTemplates: Template.find({owner: userId}, {sort: {name: 1}})
      sharedTemplates: Template.find({owner: { $ne: userId }, "sharing.shared": true}, {sort: {name: 1}})
      queue: FolderQueue.findOne({}, {sort: {addedAt: -1}})
    onBeforeAction: ->
      Session.set("template", undefined)
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/templates')
      Meteor.call("syncProfile")
      @next()


  @route 'createTemplate',
    path: '/template/create'
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/template/create')
      Meteor.call("syncProfile")
      @next()
      

  @route 'manageTemplates',
    path: '/manage'
    waitOn: ->
      Meteor.subscribe 'Template'
      Meteor.subscribe 'sharedTemplate'
      Meteor.subscribe 'UserProfiles'
    data: ->
      userId = Meteor.userId()
      privateTemplates: Template.find({owner: userId}, {sort: {createdAt: 1}})
      sharedTemplates: Template.find({owner: { $ne: userId }, "sharing.shared": true}, {sort: {name: 1}})
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/manage')
      Meteor.call("syncProfile")
      @next()


  @route 'viewTemplate',
    path: '/manage/:_id'
    waitOn: ->
      Meteor.subscribe 'Template'
      Meteor.subscribe 'sharedTemplate'
      Meteor.subscribe 'UserProfiles'
    data: ->
      template: Template.findOne(this.params._id)
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('/manage/:_id')
      Meteor.call("syncProfile")
      @next()


  @route 'notFound',
    path: '*'
    layoutTemplate: 'homeLayout'
    onBeforeAction: ->
      if Meteor.settings.public.environment == "prod"
        GARecordPage('404')
