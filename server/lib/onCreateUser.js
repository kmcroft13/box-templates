Accounts.onCreateUser(function(options, user) {
    user.emails = [{ address: options.email, verified: false }];
    if (options.profile)
        user.profile = options.profile;
    return user;
});
