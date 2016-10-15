Template.managePrivate.events(
  'click .delete': ->
    Session.set('templateToDelete', this._id)
    $('#deleteTemplateModal')
      .modal({
        blurring: true,
        onApprove: ->
          console.log("Calling deleteTask...")
          templateId = Session.get('templateToDelete')
          console.log("Calling deleteTask on: " + templateId)
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
