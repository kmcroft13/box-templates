Meteor.methods({

  'updateActive'(templateId, activeStatus) {
    console.log("### UPDATING TEMPLATE ###");
    check(templateId, Match.Any);

    Template.update(templateId, { $set: { 
        active: activeStatus 
    } });



    console.log(JSON.stringify({
        resource: "template",
        action: "update",
        details: {
          id: templateId,
          active: activeStatus
        },
        requester: Meteor.userId()
    }));
  } //End updateActive method
});
