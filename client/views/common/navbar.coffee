Template.navbar.onRendered -> (

  # fix main menu to page on passing
  this.$('#navbar').visibility({
    type: 'fixed'
  })

  # show dropdown on click
  Meteor.setTimeout(->
      this.$('#profile').dropdown({
      on: 'click',
      action: 'hide'
      })
    ,500)

)
