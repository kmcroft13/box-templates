Meteor.methods({

  'addTemplate'(templateName, templateDescription, items, usesDynamicRename, findValues) {
    console.log("### ADDING TEMPLATE ###");
    check(templateName, Match.Any);
    check(templateDescription, Match.Any);
    check(items, Match.Any);
    check(usesDynamicRename, Match.Any);
    check(findValues, Match.Any);

    if (usesDynamicRename == true) {
      dynamicRenameObj = {
        isUsing: true,
        findValues: findValues
      }
    } else {
      dynamicRenameObj = {
        isUsing: false
      }
    }

    const newTemplateId = Template.insert({
      name: templateName,
      active: true,
      createdAt: new Date(),
      owner: Meteor.userId(),
      description: templateDescription,
      items: items,
      dynamicRename: dynamicRenameObj,
      sharing: {
          shared: false
      },
    });

    console.log(JSON.stringify({
        resource: "template",
        action: "create",
        details: {
          templateName: templateName,
          id: newTemplateId,
        },
        requester: Meteor.userId()
    }));
    return newTemplateId;
  } //End addTemplate method
});
