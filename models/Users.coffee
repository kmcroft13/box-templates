UserProfile = new SimpleSchema

  fullName:
    type: String
    optional: true

  boxEntName:
    type: String
    optional: true

  boxRole:
    type: String
    optional: true

  boxTariff:
    type: String
    optional: true

  eid:
    type: String
    optional: true

  avatar:
    type: String
    optional: true


User = new SimpleSchema

  emails:
    type: [Object]
    optional: true

  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email

  "emails.$.verified":
    type: Boolean

  createdAt:
    type: Date

  profile:
    type: UserProfile
    optional: true

  services:
    type: Object
    optional: true
    blackbox: true

  roles:
    type: [String]
    blackbox: true
    optional: true


Meteor.users.attachSchema User
