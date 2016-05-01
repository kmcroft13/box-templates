Router.map ->

  @route 'templates',
    path: '/templates'
    layout: 'basicLayout'
    waitOn: ->
        Meteor.subscribe 'Template'
    data: ->
        privateTemplates: Template.find({owner: Meteor.userId()}, {sort: {name: 1}})


  @route 'server',
    path: '/server'
    where: 'server'
    action: ->
      console.log("this.params: ", this.params)
      console.log("this.request.body: ", this.request.body)
      console.log("this.request.query: ", this.request.query)
      @next()


  @route 'managePrivate',
    path: '/manage/private'
    layout: 'basicLayout'
    waitOn: ->
        Meteor.subscribe 'Template'
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
