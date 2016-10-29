Meteor.methods({

  'deleteTemplate'(templateId) {
    console.log("### DELETING TEMPLATE ###");
    check(templateId, Match.Any);
    
    Template.remove(templateId);

    console.log(JSON.stringify({
        resource: "template",
        action: "delete",
        details: {
          id: templateId,
        },
        requester: Meteor.userId()
    }));
  } //End deleteTemplate method
});
