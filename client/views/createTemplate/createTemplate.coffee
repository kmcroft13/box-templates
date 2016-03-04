Template['createTemplate'].onRendered -> (
  # initialize checkboxes
  this.$('.ui.checkbox').checkbox()

)

Template['createTemplate'].helpers(
)


Template['createTemplate'].events(

    'submit form': (e) -> (
      e.preventDefault();
      console.log("Form: " + e.type);
      templateName = e.target.templateName.value
      active = e.target.active.checked
      folderName = e.target.folderName.value
      folderId = e.target.folderId.value
      Meteor.call('addTemplate', templateName, active, folderName, folderId, (error, result) -> (
          if error
             console.log(JSON.stringify(error,null,2))
          else
             console.log(result)
      ))
      console.log("Called addTemplate method: " + templateName);
    )

)
