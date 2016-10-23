Meteor.methods({

    syncProfile: function() {
        // avoid blocking other method calls from the same client
        this.unblock();

        const lastSync = Meteor.user().profile.lastSync;

        if ( (Meteor.user()) && ((lastSync == undefined) || (Date.now() - lastSync - 43200000 > 0)) ) {

            // Check if Box access token is expired
            console.log("Checking token expiration...");
            const tokenExpiration = Meteor.user().services.box.expiresAt;
            if (Date.now() - tokenExpiration > 0) {
                // Token is expired. Refresh access token.
                console.log("Token Expired. Running \"refreshToken\" function...");
                Meteor.myFunctions.refreshToken();
            } else {
                // Token is valid
                console.log("Token Valid");
            }

            // Ready to get user information from Box
            console.log("Syncing profile with Box...");

            // Get Box access token from User object
            const accessToken = Meteor.user().services.box.accessToken;

            // Get basic user identity (ie. Name, Email, Avatar URL) from Box
            try {
                var identity = HTTP.get(
                    "https://www.box.com/api/2.0/users/me",
                    {params: {access_token: accessToken}}).data
            } catch (err) {
                throw _.extend(new Error("Failed to fetch identity from Box. " + err.message),
                    {response: err.response})
            }

            // Get user extended identity (ie. role and enterprise info) from Box
            try {
                var extendedIdentity = HTTP.get(
                    "https://www.box.com/api/2.0/users/me?fields=role,enterprise",
                    {params: {access_token: accessToken}}).data
            } catch (err) {
                throw _.extend(new Error("Failed to fetch user role and enterprise info from Box. " + err.message),
                    {response: err.response})
            }

            // Get user Group membership from Box and build array with Object
            var Groups = [];

            try {
                const groupsResponse = HTTP.get(
                    "https://www.box.com/api/2.0/users/me/memberships",
                    {params: {access_token: accessToken}}).data;

                _.each(groupsResponse.entries, function(value, key){
                    let group = {
                        "id": value.group.id,
                        "name": value.group.name,
                        "role": value.role
                    };

                    Groups.push(group);
                });
            } catch (err) {
                throw _.extend(new Error("Failed to fetch group membership from Box. " + err.message),
                    {response: err.response})
            }

            // Write everything to the user profile
            Meteor.users.update({_id: Meteor.userId()}, {
                $set: {
                    "profile": {
                        fullName: identity.name,
                        avatar: identity.avatar_url,
                        boxRole: extendedIdentity.role,
                        boxTariff: extendedIdentity.enterprise.type,
                        eid: extendedIdentity.enterprise.id,
                        boxEntName: extendedIdentity.enterprise.name,
                        boxGroups: Groups,
                        lastSync: Date.now()
                    }
                }
            });

            console.log("Sync successful!");

        } else {
            // Didn't meet if criteria to Sync
            console.log("Synced within last 12 hours");
        }

    }, // end syncProfile method

}); // end all methods