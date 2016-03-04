Router.map ->

  @route 'allTemplates',
    path: '/templates'
    layout: 'basicLayout'
    waitOn: ->
      [
        Meteor.subscribe 'Template'
      ]
    data: ->
        privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {createdAt: 1}})


  @route 'createTemplate',
    path: '/template/create'
    layout: 'basicLayout'


  @route 'viewTemplate',
    path: '/template/:_id/view'
    layout: 'basicLayout'
    waitOn: ->
      [
        Meteor.subscribe 'Template'
      ]
    data: ->
        template: Template.findOne({$and: [{_id: this.params._id},{owner: Meteor.userId()}]})


  @route 'signOut',
    path: '/sign-out'
    onBeforeAction: ->
      AccountsTemplates.logout()
      @redirect '/'
      @next()
