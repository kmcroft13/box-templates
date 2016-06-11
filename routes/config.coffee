#To allow non-logged in users to access more routes, add it in the config file
Router.plugin 'ensureSignedIn', except: [
  'home'
  '/'
  'newHome'
  '/new'
]


Router.configure(
  layoutTemplate: 'basicLayout',
  notFoundTemplate: 'notFound',
  loadingTemplate: 'loading'
)


AccountsTemplates.configureRoute('signIn',
  name: 'signin',
  path: '/login',
  layoutTemplate: 'accountsLayout'
)

AccountsTemplates.configureRoute('ensureSignedIn',
  #template: 'myLogin',
  layoutTemplate: 'accountsLayout'
)
