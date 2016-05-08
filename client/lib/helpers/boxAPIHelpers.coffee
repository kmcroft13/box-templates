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
    ###
    tokenExpiration = Meteor.user().services.box.expiresAt
    if Date.now() - tokenExpiration > 0
      console.log("Token Expired")
      Meteor.call("refreshToken")
    ###
    console.log("Preparing to copy Box folder (" + sourceFolder + ") as " + targetFolderName + "...")
    Session.set("templateStatus","copy")
    Meteor.call('copyTemplate', sourceFolder, targetFolderName, (error, result) ->
      # The method call sets the Session variable to the callback value
      if error
         console.log(error)
         $("#errorDesc").text(error.reason)
         Session.set("folderToCopy",undefined)
         Session.set("templateStatus","fail")
      else
         console.log(result)
         $('form').form('clear')
         $("#folderName").text(result.name)
         Session.set("folderToCopy",undefined)
         Session.set("templateStatus","success")
    )

)
