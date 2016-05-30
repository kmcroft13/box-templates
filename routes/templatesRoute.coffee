Router.map ->

  @route 'templates',
    path: '/templates'
    layoutTemplate: 'basicLayout'
    waitOn: ->
      Meteor.subscribe 'Template'
      Meteor.subscribe 'FolderQueue'
      Meteor.subscribe 'UserData'
    data: ->
      privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {name: 1}})
      queue: FolderQueue.findOne({}, {sort: {addedAt: -1}})
    onBeforeAction: ->
      Meteor.myFunctions.animateOut()
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()
    onAfterAction: ->
      Meteor.myFunctions.animateIn()

  @route 'managePrivate',
    path: '/manage/private'
    layoutTemplate: 'basicLayout'
    waitOn: ->
      Meteor.subscribe 'Template'
    data: ->
      privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {createdAt: 1}})
    onBeforeAction: ->
      Meteor.myFunctions.animateOut()
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()
    onAfterAction: ->
      Meteor.myFunctions.animateIn()


  @route 'createTemplate',
    path: '/template/create'
    layoutTemplate: 'basicLayout'
    onBeforeAction: ->
      Meteor.myFunctions.animateOut()
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()
    onAfterAction: ->
      Meteor.myFunctions.animateIn()


  @route 'viewTemplate',
    path: '/template/:_id/view'
    layoutTemplate: 'basicLayout'
    waitOn: ->
      Meteor.subscribe 'Template'
    data: ->
      template: Template.findOne({$and: [{_id: this.params._id},{owner: Meteor.userId()}]})
    onBeforeAction: ->
      Meteor.myFunctions.animateOut()
      sync = Meteor.call("syncProfile")
      Accounts.onLogin(sync)
      @next()
    onAfterAction: ->
      Meteor.myFunctions.animateIn()


  @route 'notFound',
    path: '*'
