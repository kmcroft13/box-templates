Template['templates'].onRendered -> (
  $('.ui.dropdown')
    .dropdown()
)


Template['templates'].helpers(
)


Template['templates'].events(

  'click .dropdown-item': (evt, tpl) ->
    description = this.description
    folderName = this.folderName
    folderId = this.folderId
    Session.set("folderToCopy",folderId)
    $("#description").text(description)
    console.log(this.name + " (" + this._id + ") selected. Session variable set for " + this.folderName + " (" + this.folderId + ")")

  'click .delete': ->
    Session.set('templateToDelete', this._id)
    $('.ui.basic.modal')
      .modal({
        blurring: true,
        onApprove: ->
          console.log("Calling deleteTask...")
          templateId = Session.get('templateToDelete')
          console.log("Calling deleteTask on: " + templateId)
          Meteor.call('deleteTask', templateId)
          Session.set('templateToDelete', undefined)
      })
      .modal('show')
)


Template['confirmModal'].events(
  'click .cancel': ->
    $('.ui.basic.modal')
      .modal('hide')
)
