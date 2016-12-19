Template.home.onRendered -> (
  # initialize FullPage.js
  $('#fullpage').fullpage(
    navigation: true,
    paddingBottom: '0px',
    css3: false
  )

  # show dropdown on click
  Meteor.setTimeout(->
      this.$('#profile').dropdown({
      on: 'click',
      action: 'hide'
      })
    ,500)

  # unhide proper <div> for section1
  if Template.find().count() > 0
    $( "#copyBody" ).removeClass('hidden')
  else
    $( "#createBody" ).removeClass('hidden')

)


Template.home.helpers(

	hasTemplates: ->
		numTemplates = Template.find().count()
		numTemplates > 0
)


Template.home.events(

  'click #createHeader': ->
    $( "#copyHeader" ).removeClass('active')
    $( "#createHeader" ).addClass('active')
    $( "#createBody" ).removeClass('hidden')
    $( "#copyBody" ).addClass('hidden')

  'click #copyHeader': ->
    $( "#createHeader" ).removeClass('active')
    $( "#copyHeader" ).addClass('active')
    $( "#copyBody" ).removeClass('hidden')
    $( "#createBody" ).addClass('hidden')
)
