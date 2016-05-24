Template.templates.events(
  'click #copyTemplate': (evt, tpl) ->
    evt.preventDefault()
    templateItems = Session.get("itemsToCopy")

    console.log("Preparing to copy items...")
    Session.set("templateStatus","copy")
    Meteor.call('copyTemplate', templateItems, (error, result) ->
      # The method call sets the Session variable to the callback value
      if error
        console.log(error)
        $("#errorDesc").text(error.reason)
        Session.set("templateStatus","fail")
      else
        $('form').form('clear')
        $("#folderName").text(result.name)
        Session.set("folderToCopy",undefined)
        result.forEach (item) ->
          type = item.type
          name = item.name
          message = item.message
          console.log(type + ", " + name + ", " + message)
          $( "#itemsCopyStatus" ).append( "<b>" + type + "</b>&nbsp;&nbsp;" + name + "&nbsp;&nbsp;" + message + "<br>");
        Session.set("templateStatus","success")
    )

)
