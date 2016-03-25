Schemas = {}
@Template = new Meteor.Collection('Template')

Schemas.Template = new SimpleSchema
  name:
    type: String

  description:
    type: String

  active:
    type: Boolean

  createdAt:
    type: Date

  owner:
    type: String

  folderName:
    type: String

  folderId:
    type: String


Template.attachSchema Schemas.Template

# Collection2 already does schema checking
# Add custom permission rules if needed
Template.allow(
  insert: (userId, doc) ->
    userId == doc.owner

  update: (userId, doc) ->
    userId == doc.owner

  remove: (userId, doc) ->
    userId == doc.owner
)

Template.helpers(
	creator: ->
		user = Meteor.users.findOne(@owner)
		user.profile.fullName

)
