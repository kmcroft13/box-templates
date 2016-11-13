Meteor.methods({

  'updateTemplateInfo'(templateId, templateName, templateDescription, activeStatus) {
    console.log("### UPDATING TEMPLATE ###");
    check(templateId, Match.Any);
    check(templateName, Match.Any);
    check(templateDescription, Match.Any);
    check(activeStatus, Match.Any);

    Template.update(templateId, { $set: { 
        name: templateName,
        description: templateDescription,
        active: activeStatus 
    } });


    console.log(JSON.stringify({
        resource: "template",
        action: "update",
        details: {
          id: templateId,
          name: templateName,
          description: templateDescription,
          active: activeStatus
        },
        requester: Meteor.userId()
    }));
  } //End updateTemplateInfo method
});
