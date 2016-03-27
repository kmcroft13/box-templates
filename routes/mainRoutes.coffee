Router.map ->

  @route 'home',
    path: '/'

  @route 'profile',
    path: '/profile'
    layout: 'basicLayout'

  @route 'signOut',
    path: '/sign-out'
    onBeforeAction: ->
      AccountsTemplates.logout()
      @redirect '/'
      @next()
