Template.templates.onRendered -> (
  $('#selectTemplate')
    .dropdown()

  $('.message .close')
    .on('click', ->
      $(this)
        .closest('.message')
        .transition('fade')
      Session.set('templateStatus','prep')
    )

  $('.ui.checkbox')
    .checkbox()

  $('#renameHelp')
    .popup()

)


Template.templates.helpers(
  itemsToCopy: ->
    Session.get('itemsToCopy')
)


Template.templates.events(

  'click .dropdown-item': (evt, tpl) ->
    description = this.description
    folderName = this.folderName
    folderId = this.folderId
    items = this.items
    $("#description").text(description)
    $('input[name="newFolderName"]').val(folderName)
    itemsCheck = Session.get("itemsToCopy")
    if itemsCheck == undefined
      $("#templateElements").transition('drop')
    Session.set("itemsToCopy", items)
    console.log(this.name + " (" + this._id + ") selected. Session variable set for " + items)


  'click #folderQuestion': ->
    $('#folderQuestionModal')
      .modal({
        blurring: true,
      })
      .modal('show')


  'click #successDetails': ->
    $('#itemsCopySuccess').transition('vertical flip')
    $('#successDetails').toggleClass('hidden')


  'click #warningDetails': ->
    $('#itemsCopyWarning').transition('vertical flip')
    $('#warningDetails').toggleClass('hidden')

  'click #renameTemplate': ->
    findReplaceArray = []
    findValues = $('.findField').map(-> return this.value ).get()
    replaceValues = $('.replaceField').map(-> return this.value ).get()
    for index of findValues
      obj = {}
      obj["find"] = findValues[index]
      obj["replace"] = replaceValues[index]
      findReplaceArray.push(obj)
    Meteor.call('renameContent', findReplaceArray)

  'click #advancedCopy': ->
    $('#advancedCopyOptions').toggleClass('hidden')
    Session.set("advancedCopy", $('input[name="advancedCopyCheckbox"]').prop("checked"))



  'click #addField': ->
    addButtonParent = $("#addField").parent();

    $( "#addField" ).remove();

    addButtonParent.append($("<div class=\"ui tiny basic red icon button removeFields\"><i class=\"minus icon\"></i></div>"));

    $( "#advancedCopyRename" ).append( "<div class=\"three fields fieldGroup\">" +
    "<div class=\"field\">" +
    "<input type=\"text\" class=\"findField smallFormInput\" name=\"find1\" placeholder=\"Find this in item names\">" +
    "</div>" +
    "<div class=\"field\">" +
    "<input type=\"text\" class=\"replaceField smallFormInput\" name=\"replace1\" placeholder=\"Replace matches with this\">" +
    "</div>" +
    "<div class=\"field\">" +
    "<div id=\"addField\" class=\"ui tiny basic blue icon button\">" +
    "<i class=\"plus icon\"></i>" +
    "</div>" +
    "</div>" +
    "</div>"
    ).fadeIn("slow");


  'click .removeFields': (evt, tmpl) ->
    removeButtonDiv = evt.target;
    removeButtonParentGroup = $( removeButtonDiv ).closest('.fieldGroup');
    removeButtonParentGroup.remove();

)


Template.folderQuestion.events(
  'click #confirm': ->
    $('#folderQuestionModal')
      .modal('hide')
)
