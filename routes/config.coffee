AccountsTemplates.configureRoute('signIn')

#To allow non-logged in users to access more routes, add it in the config file
Router.plugin 'ensureSignedIn', except: [
  'home'
  '/'
]
