###
Template.boxAPIresponse.helpers({
  boxResponse: function () {

    Meteor.setTimeout(function() {
      Session.set('boxResponse', undefined);
    }, 7000);

    return Session.get('boxResponse');
  }
});
###

Template.templates.events(
  'click #copyTemplate': (evt, tpl) ->
    sourceFolder = Session.get("folderToCopy")
    targetFolderName = $('input[name="newFolderName"]').val()

    console.log("Preparing to copy Box folder (" + sourceFolder + ") as " + targetFolderName + "...")

    Meteor.call('copyTemplate', sourceFolder, targetFolderName, (error, result) ->
      # The method call sets the Session variable to the callback value
      if error
         console.log(error)
         Session.set("folderToCopy",undefined)
         $('.positive').addClass('hidden')
         $("#errorDesc").text(error.reason)
         $('.negative').removeClass('hidden')
         $('html, body').animate(
           scrollTop: 0, 300)
      else
         console.log(result)
         Session.set("folderToCopy",undefined)
         $('.negative').addClass('hidden')
         $('form').form('clear')
         $("#folderName").text(result.name)
         $('.positive').removeClass('hidden')
         $('html, body').animate(
           scrollTop: 0, 300)
    )

)
