GARecordPage = function(pageLocation) {
  ga('create', 'UA-78647216-1', 'auto');
  if (Meteor.userId()) {
    var user = Meteor.userId();
    ga('set', 'userId', user); // Set the user ID using signed-in user_id
  }
  ga('send', 'pageview', {
    page: pageLocation
  });
};
