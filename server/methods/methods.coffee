Meteor.methods({
  addTemplate: (templateName, active, templateDescription, items) -> (
    check(templateName, Match.Any)
    check(active, Match.Any)
    check(templateDescription, Match.Any)
    check(items, Match.Any)

    newTemplateId = Template.insert({
      name: templateName,
      active: active,
      createdAt: new Date(),
      owner: Meteor.userId(),
      description: templateDescription,
      items: items
    })
    newTemplateId
    ###
    Email.send(
      to: "k.croft@me.com",
      from: "cloudtemplates@icloud.com",
      subject: "Test Email",
      text: "The contents of our email in plain text."
    )
    ###
    console.log("New Template (" + templateName + ") Created: " + newTemplateId)
),

  deleteTemplate: (templateId) -> (
    check(templateId, Match.Any)

    ###
    var template = Template.findOne(templateId)
    if template.private && template.owner !== Meteor.userId() (
      # If the task is private, make sure only the owner can delete it
      throw new Meteor.Error("not-authorized");
    )
    ###

    Template.remove(templateId)
    console.log("Template Removed: " + templateId)
 ),

###
 setChecked: function (taskId, setChecked) {
   Tasks.update(taskId, { $set: { checked: setChecked} });
   var task = Tasks.findOne(taskId);
   if (task.private && task.owner !== Meteor.userId()) {
     // If the task is private, make sure only the owner can check it off
     throw new Meteor.Error("not-authorized");
   }
 },

  setPrivate: function (taskId, setToPrivate) {
    var task = Tasks.findOne(taskId);

    // Make sure only the task owner can make a task private
    if (task.owner !== Meteor.userId()) {
      throw new Meteor.Error("not-authorized");
    }

    Tasks.update(taskId, { $set: { private: setToPrivate } });
  }
###
})
