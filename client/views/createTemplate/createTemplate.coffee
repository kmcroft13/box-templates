Template.createTemplate.onRendered -> (
  # initialize checkboxes
  this.$('.ui.checkbox').checkbox()

)


Template.createTemplate.events(

  'click .message .close': ->
    $('.message')
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
           $('.message').removeClass('positive')
           $('.message').addClass('negative')
           $("#messageTitle").text("Something went wrong")
           $("#messageBody").html("<b>" + error.reason + "</b>. Please try again.")
           $('.message').removeClass('hidden')
           $('html, body').animate(
             scrollTop: 0, 300)
        else
           console.log(result)
           $('form').form('clear')
           $('.message').removeClass('negative')
           $('.message').addClass('positive')
           $("#messageTitle").text("Success!")
           $("#messageBody").html("<b>" + templateName + "</b> was successfully created")
           $('.message').removeClass('hidden')
           $('html, body').animate(
             scrollTop: 0, 300)
    ))
    console.log("Called addTemplate method: " + templateName);
  )

)
