Meteor.methods({

  'addTemplate'(newTemplateObj) {
    console.log("### BEGIN addTemplate METHOD ###");
    check(newTemplateObj, Match.Any);

    let sharingObj;
    let dynamicRenameObj;
    const boxRole = Meteor.user().profile.boxRole;

    if (newTemplateObj.usesSharing == true && (boxRole == "admin" || boxRole == "coadmin")) {
      sharingObj = {
        shared: true,
        eid: Meteor.user().profile.eid
      }
    } else {
      sharingObj = {
        shared: false
      }
    }

    if (newTemplateObj.usesDynamicRename == true) {
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
      name: newTemplateObj.templateName,
      active: true,
      createdAt: new Date(),
      owner: Meteor.userId(),
      description: newTemplateObj.templateDescription,
      items: newTemplateObj.items,
      dynamicRename: dynamicRenameObj,
      sharing: sharingObj,
    });

    console.log(JSON.stringify({
        resource: "template",
        action: "create",
        callingMethod: "addTemplate",
        details: {
          templateName: newTemplateObj.templateName,
          id: newTemplateId,
        },
        requester: Meteor.userId()
    }));

    return newTemplateId;

    console.log("### END addTemplate METHOD ###");
  } //End addTemplate method
});
