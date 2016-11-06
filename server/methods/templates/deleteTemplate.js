Meteor.methods({

  'deleteTemplate'(templateId) {
    console.log("### DELETING TEMPLATE ###");
    check(templateId, Match.Any);
    const templateObject = Template.findOne(templateId);

    if (templateObject.owner != Meteor.userId()) {
      throw new Meteor.Error(401, "This user is not authorized to complete this request");
    } else {
      Template.remove(templateId);
    }

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
