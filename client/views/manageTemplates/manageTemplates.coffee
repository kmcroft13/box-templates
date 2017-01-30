Template.privateTemplate.onRendered -> (
  # initialize tooltips
  this.$('.tooltipped').tooltip()
  # initialize modals
  $('.modal').modal()

  $('#deleteTemplateModal').modal({
      opacity: .5,
      complete: ->
        confirmed = Session.get('userDeleteConfirm')
        if confirmed == true
          templateId = Session.get('templateToDelete')
          console.log("Calling deleteTemplate on: " + templateId)
          ga('send', 'event', 'TEMPLATE_DELETE', 'success')
          Meteor.call('deleteTemplate', templateId)
          Session.set('templateToDelete', undefined)
        else
          Session.set('templateToDelete', undefined)
          console.log('User cancelled Template deletion')
    })

)

Template.manageTemplates.events(
  'click .deleteConfirm': ->
    Session.set('templateToDelete', this._id)
    $('#deleteTemplateModal').modal('open')
)


Template.deleteModal.events(
  'click .delete': ->
    Session.set('userDeleteConfirm', true)
)
