Template['templates'].onRendered -> (
  $('.ui.dropdown')
    .dropdown()
)


Template['templates'].helpers(
)


Template['templates'].events(

  'click .dropdown-item': (evt, tpl) ->
    console.log(this.name + " (" + this._id + ") selected");
    description = this.description
    $("#description").text(description)

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
