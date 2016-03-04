// Define App Constants

if (Meteor.App) {
  throw new Meteor.Error('Meteor.App already defined? see client/lib/constants.js');
}

Meteor.App = {
  NAME: 'CloudTemplates for Box',
  DESCRIPTION: 'Templatize you Box content with ease using CloudTemplates for Box'
};
