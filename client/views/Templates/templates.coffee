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
)


Template.templates.helpers(
  'folderSelected': ->
    Session.get("folderToCopy")
)


Template.templates.events(

  'click .dropdown-item': (evt, tpl) ->
    description = this.description
    folderName = this.folderName
    folderId = this.folderId
    items = this.items
    Session.set("folderToCopy",folderId)
    Session.set("itemsToCopy", items)
    $("#description").text(description)
    $('input[name="newFolderName"]').val(folderName)
    $("#copyTemplate").removeClass("disabled")
    $("#formElements").removeClass("hidden")
    console.log(this.name + " (" + this._id + ") selected. Session variable set for " + items)

  'click #folderQuestion': ->
    $('#folderQuestionModal')
      .modal({
        blurring: true,
      })
      .modal('show')
)


Template.folderQuestion.events(
  'click #confirm': ->
    $('#folderQuestionModal')
      .modal('hide')
)
