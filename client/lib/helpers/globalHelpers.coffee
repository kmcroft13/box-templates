
UI.registerHelper('isLoggedIn', ->
  !!Meteor.user()
)


Template.registerHelper('longDate', (date) ->
  moment(date).format('MMMM Do, YYYY [at] h:mma')
)


Template.registerHelper('shortDate', (date) ->
  moment(date).format('MMM D, YYYY')
)


Handlebars.registerHelper 'niceName', (_id)->
	if _id
		user = Meteor.users.findOne _id

	if user
		if user.username
			user.username
		else if typeof user.profile != 'undefined' and user.profile.fullName
			user.profile.fullName
		else if user.emails[0].address
			user.emails[0].address
		else
			'A user'
