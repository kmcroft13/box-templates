Schemas = {}
@FolderQueue = new Meteor.Collection('FolderQueue')

Schemas.FolderQueue = new SimpleSchema
  folderName:
    type: String

  folderId:
    type: String

  boxUserId:
    type: String


FolderQueue.attachSchema Schemas.FolderQueue

# Collection2 already does schema checking
# Add custom permission rules if needed
###
FolderQueue.allow(
  insert: (userId, doc) ->
    userId == doc.owner

  update: (userId, doc) ->
    userId == doc.owner

  remove: (userId, doc) ->
    userId == doc.owner
)
###

FolderQueue.helpers(
	creator: ->
		user = Meteor.users.findOne(@owner)
		user.profile.fullName

)
