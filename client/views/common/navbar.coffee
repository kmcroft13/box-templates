Template['navbar'].onRendered -> (

  # show dropdown on hover
  this.$('.dropdown').dropdown({
    on: 'click'
  })

  # fix main menu to page on passing
  this.$('.main.menu').visibility({
    type: 'fixed'
  })

)
