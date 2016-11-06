Template.privateTemplate.onRendered -> (
  $('#sharedIcon')
    .popup()
)

Template.manageTemplates.events(
  'click .delete': ->
    Session.set('templateToDelete', this._id)
    $('#deleteTemplateModal')
      .modal({
        blurring: true,
        onApprove: ->
          console.log("Calling deleteTemplate...")
          templateId = Session.get('templateToDelete')
          console.log("Calling deleteTemplate on: " + templateId)
          ga('send', 'event', 'TEMPLATE_DELETE', 'success')
          Meteor.call('deleteTemplate', templateId)
          Session.set('templateToDelete', undefined)
      })
      .modal('show')
)


Template.deleteModal.events(
  'click .cancel': ->
    $('#deleteTemplateModal')
      .modal('hide')
)
