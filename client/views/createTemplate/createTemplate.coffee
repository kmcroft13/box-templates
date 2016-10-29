Template.createTemplate.onRendered -> (
  # initialize checkboxes
  this.$('.ui.checkbox').checkbox()

  # initialize form validation
  $('.ui.form')
    .form(
      fields:
        templateName:
          identifier: 'templateName',
          rules: [
              type   : 'empty',
              prompt : 'Please enter a Template name'
          ],
        templateDescription:
          identifier: 'templateDescription',
          rules: [
              type   : 'empty',
              prompt : 'Please enter a Template description'
          ],
        templateItems:
          identifier: 'templateItems',
          rules: [
            type   : 'minLength[6]',
            prompt : 'Please add files and folders using the &quot;Select from Box&quot; button'
          ]
    )

  $('.ui.checkbox')
    .checkbox()

  $('#renameHelp')
    .popup()

)


Template.createTemplate.helpers(
  templateItems: ->
    Session.get('items')
)


Template.createTemplate.events(

  'click .message .close': ->
    $('.message')
      .closest('.message')
      .transition('fade')


  'submit form': (e) -> (
    e.preventDefault()
    console.log("Form: " + e.type);
    templateName = e.target.templateName.value
    templateDescription = e.target.templateDescription.value
    items = Session.get("items")
    usesDynamicRename = $('input[name="advancedCopyCheckbox"]').is(':checked')
    findValues = $('.findField').map(-> if this.value != null && this.value != "" then return this.value ).get()
    Meteor.call('addTemplate', templateName, templateDescription, items, usesDynamicRename, findValues, (error, result) -> (
        if error
           console.log(JSON.stringify(error,null,2))
           ga('send', 'event', 'TEMPLATE_CREATE', 'failed')
           $('#createMessage').removeClass('positive')
           $('#createMessage').addClass('negative')
           $("#messageTitle").text("Something went wrong")
           $("#messageBody").html("<b>" + error.reason + "</b>. Please try again.")
           $('#createMessage').removeClass('hidden')
           $('html, body').animate(
             scrollTop: 0, 300)
        else
           console.log(result)

           if findValues.length > 0
              ga('send', 'event', 'TEMPLATE_CREATE', 'success_with_findReplace')
           else
              ga('send', 'event', 'TEMPLATE_CREATE', 'success')

           $('form').form('clear')
           $('#advancedCopyOptions').toggleClass('hidden')
           $('#createMessage').removeClass('negative')
           $('#createMessage').addClass('positive')
           $("#messageTitle").text("Success!")
           $("#messageBody").html("<b>" + templateName + "</b> was successfully created. Now <b><a href=\"/templates\">let's put it to work</a></b>!")
           $('#createMessage').removeClass('hidden')
           Session.set("items", undefined)
           $('html, body').animate(
             scrollTop: 0, 300)
    ))
    console.log("Called addTemplate method: " + templateName);
  )


  'click #advancedCopy': ->
    $('#advancedCopyOptions').toggleClass('hidden')
    Session.set("advancedCopy", $('input[name="advancedCopyCheckbox"]').prop("checked"))


  'click #addField': ->
    addButtonParent = $("#addField").parent();

    $( "#addField" ).remove();

    addButtonParent.append($("<div class=\"ui tiny basic red icon button removeFields\"><i class=\"minus icon\"></i></div>"));

    $( "#advancedCopyRename" ).append( "<div class=\"two fields fieldGroup\">" +
    "<div class=\"field\">" +
    "<input type=\"text\" class=\"findField smallFormInput\" name=\"find1\" placeholder=\"Find this in item names\">" +
    "</div>" +
    "<div class=\"field\">" +
    "<div id=\"addField\" class=\"ui tiny basic blue icon button\">" +
    "<i class=\"plus icon\"></i>" +
    "</div>" +
    "</div>" +
    "</div>"
    ).fadeIn("slow");


  'click .removeFields': (evt, tmpl) ->
    removeButtonDiv = evt.target;
    removeButtonParentGroup = $( removeButtonDiv ).closest('.fieldGroup');
    removeButtonParentGroup.remove();


)
