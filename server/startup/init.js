//Initialize Box client
const BoxSDK = require('box-node-sdk');

sdk = new BoxSDK({
  clientID: Meteor.settings.serviceConfigurations.box.appId, // required
  clientSecret: Meteor.settings.serviceConfigurations.box.secret // required
});


//Initialize scheduled tasks
SyncedCron.start();