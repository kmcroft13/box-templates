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

  dynamicRename:
    type: Object
    blackbox: true

  "dynamicRename.$.isUsing":
    type: Boolean

  "dynamicRename.$.findValues":
    type: Array
    optional: true

  "dynamicRename.$.findValues.$":
    type: String

  sharing:
    type: Object
    blackbox: true

  "sharing.$.shared":
    type: Boolean

  "sharing.$.scope":
    type: String
    allowedValues: ['enterprise', 'group']
    optional: true

  "sharing.$.groups"
    type: [Object]
    optional: true

  "sharing.$.eid"
    type: String
    optional: true


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
		if user then user.profile.fullName else "Unknown"
)
