###
Template['allTemplates'].onRendered -> (

)
###

Template['templates'].helpers(
)


Template['templates'].events(
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
