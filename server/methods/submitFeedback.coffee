Meteor.methods(

 submitFeedback: (feedbackType, feedbackText) -> (

    check(feedbackType, Match.Any)
    check(feedbackText, Match.Any)

    #Card creation has begun
    console.log("Create Trello Card")

    #Get Current User info
    userId = Meteor.userId()
    userName = Meteor.user().profile.fullName
    userEmail = Meteor.user().emails[0].address
    userEnt = Meteor.user().profile.boxEntName

    #Put objectIDs for Trello labels in JS variables
    userReportedLabel = '574a5e3b505999ad434ce691'
    suggestionLabel = '574a5e3b505999ad434ce692'
    bugLabel = '574a5e3b505999ad434ce690'

    #Build and format data that will be placed in the card. Data is different for bug submissions and feature requests
    #Formatted data is put into cardName and cardDesc, depending on card type, and sent in payload (below)
    #Trello uses markup for formatting, so markup is added to the string so it is formatted when added to Trello

    console.log("Build and format card data...")

    if feedbackType == "Bug"
      cardName = "[BUG] " + "Reported by " + userName + ""
    else if feedbackType == "Suggestion"
      cardName = "[SUGGESTION] " + "Reported by " + userName + ""
    else if feedbackType == "Question"
      cardName = "[QUESTION] " + "Asked by " + userName + ""
    else
      cardName = "[OTHER] " + "Reported by " + userName + ""

    #Footer data is shared between both types of cards and is appended to cardDesc
    userInfo = "\n\n" + "**Reported by: **" + userName + "\n" + "**User ID: **" + userId + "\n" + "**User Email: **" + userEmail + "\n" + "**User Enterprise: **" + userEnt + "\n" + "**Reported on: **" + new Date().toString() + ""

    cardDesc = feedbackType + "\n" + "----------" + "\n\n" + feedbackText + "\n\n" + userInfo

    console.log("Success!")

    #Build labels depending on data from the form. This will be sent in payload (below)
    console.log("Build labels...")

    labels = userReportedLabel #This label is added to all submitted cards

    #If bug report, add BUG label
    if feedbackType == "Bug"
      labels = labels + "," + bugLabel
    else if feedbackType == "Question"
      labels = labels
    else
      labels = labels + "," + suggestionLabel

    console.log("Success!")

    #Send POST payload data to Trello API
    #POST [/1/cards], Required permissions: write
    console.log("Add card to Trello...")

    #Variables for Trello app key and token
    TrelloKey = "777e91a955ddc9e0338d9239df0efdbd" #Key to Trello app - SPECIFIC TO KYLE CROFT TRELLO ACCOUNT
    TrelloToken = "2b4659248ba6ab4b92975a59934599c3a80e5482857f9fc43c62cab5b83a201c" #Token for authorization - SPECIFIC TO KYLE CROFT ACCOUNT

    #Because payload is a JavaScript object, it will be interpreted as an HTML form
    url = "https://api.trello.com/1/cards?key=" + TrelloKey + "&token=" + TrelloToken + ""
    response = HTTP.post(url, {
      data: {
        "name": cardName,
        "desc": cardDesc,
        "pos": "bottom",
        "due": "", #(required) A date, or null
        "idList": "574a5e3b505999ad434ce686", #(required) id of the list that the card should be added to
        "idLabels": labels
      }
    })

    console.log("Card successfully sent!")
  )

)
