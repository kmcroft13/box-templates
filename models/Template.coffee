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

  items:
    type: [Object]
    blackbox: true

  "items.$.id":
    type: String

  "items.$.name":
    type: String

  "items.$.access":
    type: String

  "items.$.permissions":
    type: [Object]
    blackbox: true

  "items.$.type":
    type: String

  "items.$.url":
    type: String

  findValues:
    type: Array
    blackbox: true

  "findValues.$":
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
