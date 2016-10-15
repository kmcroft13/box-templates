Template['viewTemplate'].onRendered -> (
  # initialize checkboxes
  this.$('.ui.checkbox').checkbox()

  $('#renameHelp')
    .popup()

)
