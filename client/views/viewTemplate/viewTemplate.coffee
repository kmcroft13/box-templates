Template['viewTemplate'].onRendered -> (
  # initialize checkboxes
  this.$('.ui.checkbox').checkbox()

  $('#renameHelp')
    .popup()

  $('#sharingHelp')
    .popup()

)


Template['viewTemplate'].helpers(
  isOwnerAndShared: ->
    isOwner = this.template.owner == Meteor.userId()
    isShared = this.template.sharing.shared
    isOwner && isShared

  isOwner: ->
    this.template.owner == Meteor.userId()
)