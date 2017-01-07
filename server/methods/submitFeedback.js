Meteor.methods({

  'submitFeedback'(feedbackType, feedbackText) {
    console.log("### BEGIN submitFeedback METHOD ###");
    check(feedbackType, Match.Any);
    check(feedbackText, Match.Any);
    
    //Get current user info
    const user = Meteor.user();
    const userId = Meteor.user()._id;
    const userFullName = user.profile.fullName;
    const userEmail = user.emails[0].address;
    const userEnt = user.profile.boxEntName;
    let cardName = "";

    //Create variables for Trello label objectIDs
    const userReportedLabel = '574a5e3b505999ad434ce691';
    const suggestionLabel = '574a5e3b505999ad434ce692';
    const bugLabel = '574a5e3b505999ad434ce690';

    //Build and format data that will be placed in the card. Data is different for bug submissions and feature requests
    //Formatted data is put into cardName and cardDesc, depending on card type, and sent in payload (below)
    //Trello uses markup for formatting, so markup is added to the string so it is formatted when added to Trello
    console.log("Build and format card data...");

    if (feedbackType == "Bug") {
        cardName = `[BUG] Reported by ${userFullName}`;
    } else if (feedbackType == "Suggestion") {
        cardName = `[SUGGESTION] Reported by ${userFullName}`;
    } else if (feedbackType == "Question") {
        cardName = `[QUESTION] Asked by ${userFullName}`;
    } else {
        cardName = `[OTHER] Reported by ${userFullName}`;
    }

    //Footer data is shared between both types of cards and is appended to cardDesc
    const userInfo = `\n\n **Reported by:** ${userFullName} \n **User ID:** ${userId} \n **User Email:** ${userEmail} \n **User Enterprise:** ${userEnt} \n **Reported on:** ${new Date().toString()}`;
    const cardDesc = `${feedbackType} \n ---------- \n\n ${feedbackText} \n\n ${userInfo}`;

    console.log("Complete");

    //Build labels depending on data from the form. This will be sent in payload (below)
    console.log("Build labels...")
    let labels = userReportedLabel; //This label is added to all submitted cards

    //Add other labels if suggestion or bug
    if (feedbackType == "Bug") {
        labels = `${labels},${bugLabel}`;
    } else if (feedbackType == "Question") {
        //do nothing
    } else {
        labels = `${labels},${suggestionLabel}`;
    }

    console.log("Complete")

    //Send POST payload data to Trello API
    //POST [/1/cards], Required permissions: write
    console.log("Add card to Trello...");

    //Variables for Trello app key and token (from Meteor settings)
    const TrelloKey = Meteor.settings.trello.key;
    const TrelloToken = Meteor.settings.trello.token;

    //Because payload is a JavaScript object, it will be interpreted as an HTML form
    const url = `https://api.trello.com/1/cards?key=${TrelloKey}&token=${TrelloToken}`;
    const response = HTTP.post(url, {
      data: {
        name: cardName,
        desc: cardDesc,
        pos: "bottom",
        due: null, //(required) A date, or null
        idList: "574a5e3b505999ad434ce686", //(required) id of the list that the card should be added to
        idLabels: labels
      }
    });

    console.log(JSON.stringify({
        resource: "feedback",
        action: "create",
        callingMethod: "submitFeedback",
        details: {
          status: "Request made to Trello",
          response: response
        },
        requester: userId
    }));

    console.log("### END submitFeedback METHOD ###");
  } //End submitFeedback method
});