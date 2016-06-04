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
        $( "#itemsCopySuccess" ).empty()
        $( "#itemsCopyWarning" ).empty()
        i = 0
        e = 0
        s = 0
        result.forEach (item) ->
          type = item.type
          name = item.name
          message = item.message
          i = i+1
          if type == "error"
            e = e+1
            $( "#itemsCopySuccess" ).append( "<div class=\"ui red horizontal label\">Failed</div>&nbsp; <b>" + name + "</b>&nbsp;&nbsp; " + message + "<br>")
            $( "#itemsCopyWarning" ).append( "<div class=\"ui red horizontal label\">Failed</div>&nbsp; <b>" + name + "</b>&nbsp;&nbsp; " + message + "<br>")
          else
            s = s+1
            $( "#itemsCopySuccess" ).append( "<div class=\"ui green horizontal label\">Created</div>&nbsp; <b>" + name + "</b>&nbsp;" + message + "<br>")
            $( "#itemsCopyWarning" ).append( "<div class=\"ui green horizontal label\">Created</div>&nbsp; <b>" + name + "</b>&nbsp;" + message + "<br>")
        if s == i
          $( "#successStatus" ).append( s + " items were successfully created &nbsp;&nbsp;&nbsp;<a id=\"successDetails\" href=\"#\">More Details...</a>")
          Session.set("templateStatus","success")
        else
          $( "#warningStatus" ).append( s + " items created and " + e + " items failed &nbsp;&nbsp;&nbsp;<a id=\"warningDetails\" href=\"#\">More Details...</a>")
          Session.set("templateStatus","warning")
    )

)
