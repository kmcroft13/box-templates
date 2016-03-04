Template['createTemplate'].onRendered -> (
  # initialize checkboxes
  this.$('.ui.checkbox').checkbox()

)

Template['createTemplate'].helpers(
)


Template['createTemplate'].events(

  'click .message .close': ->
    $(this)
      .closest('.message')
      .transition('fade')


  'submit form': (e) -> (
    e.preventDefault();
    console.log("Form: " + e.type);
    templateName = e.target.templateName.value
    active = e.target.active.checked
    folderName = e.target.folderName.value
    folderId = e.target.folderId.value
    templateDescription = e.target.templateDescription.value
    Meteor.call('addTemplate', templateName, active, folderName, folderId, templateDescription, (error, result) -> (
        if error
           console.log(JSON.stringify(error,null,2))
           $('.positive').addClass('hidden')
           $("#errorDesc").text(error.reason)
           $('.negative').removeClass('hidden')
           $('html, body').animate(
             scrollTop: 0, 300)
        else
           console.log(result)
           $('.negative').addClass('hidden')
           $('form').form('clear')
           $("#templateName").text(templateName)
           $('.positive').removeClass('hidden')
           $('html, body').animate(
             scrollTop: 0, 300)
    ))
    console.log("Called addTemplate method: " + templateName);
  )

)
