Template.home.onRendered -> (
  $('#fullpage').fullpage(
    scrollOverflow: false
  )

  # show dropdown on click
  Meteor.setTimeout(->
      this.$('#profile').dropdown({
      on: 'click',
      action: 'hide'
      })
    ,500)

)
