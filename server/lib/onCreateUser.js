Accounts.onCreateUser(function(options, user) {
    user.emails = [{ address: options.email, verified: false }];
    if (options.profile)
        user.profile = options.profile;

    var id = 1;
    var userEmail = options.email;
    var fullName = options.profile.fullName;
    var sendinblueKey = Meteor.settings.email.sendinblueKey;

    var apiURL = 'https://api.sendinblue.com/v2.0/template/' + id;
    var response = HTTP.put(apiURL, {
      headers: {'api-key': sendinblueKey},
      data: {
        'to': userEmail,
        'attr':{'NAME': fullName}
      }
    });

    return user;
});
