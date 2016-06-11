Template.home.onRendered -> (
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

)
