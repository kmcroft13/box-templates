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
  itemsToCopy: ->
    Session.get('itemsToCopy')
)


Template.templates.events(

  'click .dropdown-item': (evt, tpl) ->
    description = this.description
    folderName = this.folderName
    folderId = this.folderId
    items = this.items
    Session.set("itemsToCopy", items)
    $("#description").text(description)
    $('input[name="newFolderName"]').val(folderName)
    $("#templateElements").transition('drop')
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
)


Template.folderQuestion.events(
  'click #confirm': ->
    $('#folderQuestionModal')
      .modal('hide')
)
