Template.home.onRendered -> (
  $('#fullpage').fullpage(
    continuousVertical: true,
    normalScrollElements: '.pusher'
  )

  # show dropdown on click
  Meteor.setTimeout(->
      this.$('#profile').dropdown({
      on: 'click',
      action: 'hide'
      })
    ,500)

)
