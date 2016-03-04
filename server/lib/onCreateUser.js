Accounts.onCreateUser(function(options, user) {
    user.email = [{ address: options.email, verified: false }];
    if (options.profile)
        user.profile = options.profile;
    return user;
});
