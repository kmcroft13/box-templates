root = exports ? this

root.Template = new Mongo.Collection 'Template'

root.Template.attachSchema(
  new SimpleSchema(
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
  )
)

# Collection2 already does schema checking
# Add custom permission rules if needed
root.Template.allow(
  insert: (userId, doc) ->
    userId == doc.owner

  update: (userId, doc) ->
    userId == doc.owner

  remove: (userId, doc) ->
    userId == doc.owner

)
