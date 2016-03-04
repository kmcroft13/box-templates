Template['navbar'].onRendered -> (
  # fix main menu to page on passing
  this.$('.main.menu').visibility({
    type: 'fixed'
  })

  # show dropdown on hover
  this.$('.main.menu  .ui.dropdown').dropdown({
    on: 'hover'
  })
)

Template['navbar'].events (
  'click .github': ->
    Meteor.loginWithBox({}, (err) ->
      if err
        throw new Meteor.Error("Box login failed")
    )
)
