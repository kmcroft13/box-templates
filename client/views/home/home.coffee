Template.home.onRendered -> (

  # show dropdown on click
  Meteor.setTimeout(->
      this.$('#profile').dropdown({
      on: 'click',
      action: 'hide'
      })
    ,500)

)
