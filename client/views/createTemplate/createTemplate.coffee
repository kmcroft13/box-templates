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
          ]
        ,
        templateDescription:
          identifier: 'templateDescription',
          rules: [
              type   : 'empty',
              prompt : 'Please enter a Template description'
          ]
    )

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
    active = true
    templateDescription = e.target.templateDescription.value
    items = Session.get("items")
    Meteor.call('addTemplate', templateName, active, templateDescription, items, (error, result) -> (
        if error
           console.log(JSON.stringify(error,null,2))
           $('#createMessage').removeClass('positive')
           $('#createMessage').addClass('negative')
           $("#messageTitle").text("Something went wrong")
           $("#messageBody").html("<b>" + error.reason + "</b>. Please try again.")
           $('#createMessage').removeClass('hidden')
           $('html, body').animate(
             scrollTop: 0, 300)
        else
           console.log(result)
           $('form').form('clear')
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

)
