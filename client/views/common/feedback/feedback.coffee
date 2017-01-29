Template.feedbackForm.onRendered -> (
  # initialize dropdown
  this.$('select').material_select()
  # initialize tooltip
  this.$('.tooltipped').tooltip()

)

Template.feedbackForm.events(

  'click #feedbackButton': ->
    feedbackButtonClass = $('#feedbackButton').attr('data-active')
    if feedbackButtonClass == 'false'
      $('#feedbackButton').attr('data-active', 'true')
      $("#feedbackButton").text("X")
      $('#feedbackButton').addClass('red')
      $('.tooltipped').tooltip('remove')
    else
      $('#feedbackButton').attr('data-active', 'false')
      $("#feedbackButton").text("?")
      $('#feedbackButton').removeClass('red')
      $('.tooltipped').tooltip()
    $('#feedbackForm').toggleClass('scale-out')


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
