Meteor.methods({

  'updateTemplateInfo'(templateId, templateName, templateDescription, activeStatus) {
    console.log("### BEGIN updateTemplateInfo METHOD ###");
    check(templateId, Match.Any);
    check(templateName, Match.Any);
    check(templateDescription, Match.Any);
    check(activeStatus, Match.Any);

    const templateObject = Template.findOne(templateId);

    if (templateObject.owner != Meteor.userId()) {
      console.log(`ERROR: Could not update template ${templateId} because requestor was not owner`)
      throw new Meteor.Error(401, "This user is not authorized to complete this request");
    }

    Template.update(templateId, { $set: { 
        name: templateName,
        description: templateDescription,
        active: activeStatus 
    } });


    console.log(JSON.stringify({
        resource: "template",
        action: "update",
        callingMethod: "updateTemplateInfo",
        details: {
          id: templateId,
          name: templateName,
          description: templateDescription,
          active: activeStatus
        },
        requester: Meteor.userId()
    }));

    console.log("### END updateTemplateInfo METHOD ###");
  } //End updateTemplateInfo method
});
