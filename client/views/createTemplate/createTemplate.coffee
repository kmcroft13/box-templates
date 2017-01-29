Template.createTemplate.onRendered -> (
  # initialize tooltips
  this.$('.tooltipped').tooltip({delay: 50})
  # initialize modals
  $('.modal').modal()
  # initialize options for sharing collab modal
  $('#sharingCollabConfirmModal').modal({
    dismissible: false,
    opacity: .5,
    complete: ->
      confirmed = Session.get('userAccessConfirm')
      newTemplateObj = Session.get('newTemplateObj')
      console.log(newTemplateObj)
      if confirmed == true
        Helpers.createTemplate(newTemplateObj)
      else
        throw new Error('User cancelled Template creation')
  })

)

Helpers = {
  createTemplate: (newTemplateObj) -> 
    Meteor.call('addTemplate', newTemplateObj, (error, result) -> (
      if error
          console.log(JSON.stringify(error,null,2))
          ga('send', 'event', 'TEMPLATE_CREATE', 'failed')
          $toastCreateError = "<b>" + error.reason + "</b>. Please try again."
          Materialize.toast($toastCreateError, 5000, 'red')
      else
          console.log(result)

          if newTemplateObj.usesDynamicRename && newTemplateObj.usesSharing
            ga('send', 'event', 'TEMPLATE_CREATE', 'success_shared_with_rename')
          else if newTemplateObj.usesDynamicRename
            ga('send', 'event', 'TEMPLATE_CREATE', 'success_private_with_rename')
          else if newTemplateObj.usesSharing
            ga('send', 'event', 'TEMPLATE_CREATE', 'success_shared')
          else
            ga('send', 'event', 'TEMPLATE_CREATE', 'success_private')

          $("form").trigger('reset')
          $toastCreateSuccess = "<b>" + newTemplateObj.templateName + "</b>&nbsp;was successfully created. Now <a href=\"/templates\">&nbsp;put it to work</a>!"
          Materialize.toast($toastCreateSuccess, 7000, 'green')
          Session.set("items", undefined)
          Session.set("usesDynamicRenameCreate", undefined)
          Session.set("newTemplateObj", undefined)
    ))
}

Template.createTemplate.helpers(
  templateItems: ->
    Session.get('items')
    
  usesDynamicRenameCreate: ->
    Session.get('usesDynamicRenameCreate')

  usesSharing: ->
    Session.get('usesSharing')

  isAdminOrCoadmin: ->
    boxRole = Meteor.user().profile.boxRole
    boxRole == "admin" || boxRole == "coadmin"

)


Template.createTemplate.events(

  'click #toast-container .toast': ->
    $(this).fadeOut( -> 
      $(this).remove() 
    )

  'click .message .close': ->
    $('.message')
      .closest('.message')
      .transition('fade')

  'submit form': (e) -> (
    e.preventDefault()
    console.log("Form: " + e.type)

    templateName = e.target.templateName.value
    templateDescription = e.target.templateDescription.value
    items = Session.get("items")
    usesSharing = $('#sharedCheckbox').prop('checked')
    usesDynamicRename = $('input[name="advancedCopyCheckbox"]').is(':checked')
    findValues = $('.findField').map(-> if this.value != null && this.value != "" then return this.value ).get()
    newTemplateObj = {
      templateName: templateName,
      templateDescription: templateDescription,
      items: items,
      usesSharing: usesSharing,
      usesDynamicRename: usesDynamicRename,
      findValues: findValues
    }
    invalid = false
    Session.set('newTemplateObj', newTemplateObj)
    if !templateName
      $('input[name="templateName"]').addClass('invalid')
      Materialize.toast('Please enter a Template name', 5000, 'red')
      invalid = true

    if !templateDescription
      $('textarea[name="templateDescription"]').addClass('invalid')
      Materialize.toast('Please enter a Template description', 5000, 'red')
      invalid = true

    if !items
      Materialize.toast('Please choose Template items by clicking &quot;Select from Box&quot;', 5000, 'red')
      invalid = true
      
    if (invalid == true)
      throw new Error('Form did not pass validation')

    if usesSharing
      $('#sharingCollabConfirmModal').modal('open')
    else
      Helpers.createTemplate(newTemplateObj)
      
    console.log("Called addTemplate method: " + templateName);
  )


  'click #advancedCopy': ->
    Session.set("usesDynamicRenameCreate", $('input[name="advancedCopyCheckbox"]').prop("checked"))

  'click #shared': ->
    Session.set("usesSharing", $('input[name="sharedCheckbox"]').prop("checked"))

  'click #addField': ->
    addButtonParent = $("#addField").parent();

    $( "#addField" ).remove();

    addButtonParent.append($("<div class=\"btn-floating btn-small waves-effect waves-light red removeFields\"><i class=\"material-icons\">remove</i></div>"));

    $( "#advancedCopyRename" ).append( "<div class=\"row fieldGroup\">" +
    "<div class=\"input-field col s8\">" +
    "<input type=\"text\" class=\"findField smallFormInput\" name=\"find1\" placeholder=\"Find this word in item names\">" +
    "</div>" +
    "<div class=\"col s4\">" +
    "<div id=\"addField\" class=\"btn-floating btn-small waves-effect waves-light blue\">" +
    "<i class=\"material-icons\">add</i>" +
    "</div>" +
    "</div>" +
    "</div>"
    ).fadeIn("slow");


  'click .removeFields': (evt, tmpl) ->
    removeButtonDiv = evt.target;
    removeButtonParentGroup = $( removeButtonDiv ).closest('.fieldGroup');
    removeButtonParentGroup.remove();

  'click #renameHelpLabelCreate': ->
    $('#renameHelpCreateModal').modal('open')

  'click #sharingHelpLabel': ->
    $('#sharingHelpModal').modal('open')


)


Template.sharingCollabConfirm.helpers(
  templateItems: ->
    Session.get('items')

)

Template.sharingCollabConfirm.events(
  'click #userAccessConfirm': ->
    Session.set('userAccessConfirm', true)
)