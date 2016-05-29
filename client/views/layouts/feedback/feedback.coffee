Template.feedbackForm.onRendered -> (
  # initialize dropdown
  this.$('.ui.dropdown').dropdown()

  $('.ui.form')
    .form(
      fields:
        feedbackType:
          identifier: 'feedbackType',
          rules: [
              type   : 'empty',
              prompt : 'Please select a feedback type'
          ]
        ,
        feedbackText:
          identifier: 'feedbackText',
          rules: [
              type   : 'empty',
              prompt : 'Please enter some feedback text'
          ]
    )

)

Template.feedbackForm.events(

  'click #helpButton': ->
    $('#feedbackForm').transition('fly up')

  'submit form': (e) -> (
    e.preventDefault()
    feedbackType = e.target.feedbackType.value
    feedbackText = e.target.feedbackText.value
    Meteor.call('submitFeedback', feedbackType, feedbackText, (error, result) -> (
        if error
           console.log(JSON.stringify(error,null,2))
           $('#feedbackMessage').removeClass('positive')
           $('#feedbackMessage').addClass('negative')
           $("#feedbackMessageTitle").text("Something went wrong")
           $("#feedbackMessageBody").html("<b>" + error.reason + "</b>. Please try again.")
           $('#feedbackMessage').removeClass('hidden')
        else
           console.log(result)
           $('form').form('clear')
           $('#feedbackMessage').removeClass('negative')
           $('#feedbackMessage').addClass('positive')
           $("#feedbackMessageTitle").text("Success!")
           $("#feedbackMessageBody").html("Feedback successfully submitted!")
           $('#feedbackMessage').removeClass('hidden')
    ))
    console.log("Called submitFeedback method")
  )

)
