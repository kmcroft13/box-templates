Template.templates.events(
  'click #copyTemplate': (evt, tpl) ->
    evt.preventDefault()
    templateItems = Session.get("template").items
    templateId = this._id
    findReplaceArray = []
    findValues = $('.findField').map(-> return this.value ).get()
    replaceValues = $('.replaceField').map(-> return this.value ).get()
    for index of findValues
      obj = {}
      obj["find"] = findValues[index]
      obj["replace"] = replaceValues[index]
      findReplaceArray.push(obj)

    console.log("Preparing to copy items...")
    Session.set("templateStatus","copy")

    Meteor.call('copyTemplate', templateItems, findReplaceArray, (error, result) ->
      # The method call sets the Session variable to the callback value
      if error
        console.log(error)
        $("#errorDesc").text(error.reason)
        Session.set("templateStatus","fail")
        ga('send', 'event', 'TEMPLATE_COPY', 'failed', templateId)
      else

        if findReplaceArray.length > 0
          ga('send', 'event', 'TEMPLATE_COPY', 'success_with_findReplace', templateId)
        else
          ga('send', 'event', 'TEMPLATE_COPY', 'success', templateId)

        $('form').form('clear')
        $( "#itemsCopySuccess" ).empty()
        $( "#itemsCopyWarning" ).empty()
        i = 0
        e = 0
        s = 0
        result.forEach (item) ->
          type = item.type
          i = i+1
          if type == "error"
            e = e+1
            name = item.name
            status = item.status
            code = item.code
            message = item.message
            $( "#itemsCopySuccess" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui red horizontal label\">Failed</div>&nbsp; <b>" + name + "</b>&nbsp;&nbsp; " + message + "<br></div>")
            $( "#itemsCopyWarning" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui red horizontal label\">Failed</div>&nbsp; <b>" + name + "</b>&nbsp;&nbsp; " + message + "<br></div>")
          else if type == "success with conflict"
            s = s+1
            name = item.name
            id = item.id
            $( "#itemsCopySuccess" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui green horizontal label\">Created</div>&nbsp; <b>" + name + "</b>&nbsp;&nbsp;copied and renamed because an item with the original name already exists<br></div>")
            $( "#itemsCopyWarning" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui green horizontal label\">Created</div>&nbsp; <b>" + name + "</b>&nbsp;&nbsp;copied and renamed because an item with the original name already exists<br></div>")
          else if type == "success with rename"
            s = s+1
            origName = item.origName
            name = item.name
            id = item.id
            $( "#itemsCopySuccess" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui green horizontal label\">Created</div>&nbsp; <b>" + origName + "</b>&nbsp;&nbsp;copied and renamed to " + name + "<br></div>")
            $( "#itemsCopyWarning" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui green horizontal label\">Created</div>&nbsp; <b>" + origName + "</b>&nbsp;&nbsp;copied and renamed to <b>" + name + "</b><br></div>")
          else
            s = s+1
            name = item.name
            id = item.id
            $( "#itemsCopySuccess" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui green horizontal label\">Created</div>&nbsp; <b>" + name + "</b>&nbsp;copied successfully<br></div>")
            $( "#itemsCopyWarning" ).append( "<div class=\"item\"><div class=\"fixedStatusLabel ui green horizontal label\">Created</div>&nbsp; <b>" + name + "</b>&nbsp;copied successfully<br></div>")
        if s == i
          $( "#successStatus" ).html( s + " items were successfully created &nbsp;&nbsp;&nbsp;<a id=\"successDetails\" href=\"#\">More Details...</a>")
          Session.set("templateStatus","success")
        else
          $( "#warningStatus" ).html( s + " items created and " + e + " items failed &nbsp;&nbsp;&nbsp;<a id=\"warningDetails\" href=\"#\">More Details...</a>")
          Session.set("templateStatus","warning")
    )

)
