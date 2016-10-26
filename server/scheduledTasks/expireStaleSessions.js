SyncedCron.add({
    name: 'Expire stale sessions',
    schedule: function(parser) {
        // parser is a later.parse object
        return parser.text('every 1 hours');
    },
    job: function() {

        // 45 days in milliseconds
        const inactivityTimeout = 3888000000;

        // set overdue timestamp to 45 days ago
        const now = new Date();
        const overdueTimestamp = new Date(now-inactivityTimeout);

        // update all users to remove active sessions if lastSync was more than 45 days ago
        const sessionsUpdated = Meteor.users.update({ $and: [ {'profile.lastSync': {$lt: overdueTimestamp}}, {'services.resume.loginTokens': {$ne: []}} ] },
            {$set: {'services.resume.loginTokens': []}});

        console.log(`${sessionsUpdated} stale sessions terminated`);

        return `${sessionsUpdated} stale sessions terminated`
    }
});