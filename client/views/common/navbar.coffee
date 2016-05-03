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
