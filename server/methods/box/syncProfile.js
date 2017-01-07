Meteor.methods({

    syncProfile: function() {
        console.log("### BEGIN syncProfile METHOD ###");

        // avoid blocking other method calls from the same client
        this.unblock();

        if ( (Meteor.user()) && ((Meteor.user().profile.lastSync == undefined) || (Date.now() - Meteor.user().profile.lastSync - 43200000 > 0)) ) {

            // Check if Box access token is expired
            const tokenExpiration = Meteor.user().services.box.expiresAt;
            if (Date.now() - tokenExpiration > 0) {
                // Token is expired. Refresh access token.
                console.log("Token Expired. Refreshing...");
                Meteor.myFunctions.refreshToken();
            } else {
                // Token is valid
                console.log("Token Valid");
            }

            // Ready to get user information from Box
            // Get Box access token from User object
            const accessToken = Meteor.user().services.box.accessToken;

            // Get basic user identity (ie. Name, Email, Avatar URL) from Box
            try {
                var identity = HTTP.get(
                    "https://www.box.com/api/2.0/users/me",
                    {params: {access_token: accessToken}}).data
            } catch (err) {
                throw _.extend(new Error("Failed to fetch identity from Box: " + err.message),
                    {response: err.response})
            }
            // Save identity properties to variables
            const fullName = identity.name;
            const avatar = identity.avatar_url;


            // Get user extended identity (ie. role and enterprise info) from Box
            try {
                var extendedIdentity = HTTP.get(
                    "https://www.box.com/api/2.0/users/me?fields=role,enterprise",
                    {params: {access_token: accessToken}}).data
            } catch (err) {
                throw _.extend(new Error("Failed to fetch user role and enterprise info from Box: " + err.message),
                    {response: err.response})
            }
            // Save extendedIdentity properties to variables
            const boxRole = extendedIdentity.role;
            const boxTariff = extendedIdentity.enterprise.type;
            const eid = extendedIdentity.enterprise.id;
            const boxEntName = extendedIdentity.enterprise.name;


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
                throw _.extend(new Error("Failed to fetch group membership from Box: " + err.message),
                    {response: err.response})
            }

            // Write everything to the user profile
            Meteor.users.update({_id: Meteor.userId()}, {
                $set: {
                    "profile": {
                        fullName: fullName,
                        avatar: avatar,
                        boxRole: boxRole,
                        boxTariff: boxTariff,
                        eid: eid,
                        boxEntName: boxEntName,
                        boxGroups: Groups,
                        lastSync: Date.now()
                    }
                }
            });

            console.log(JSON.stringify({
                resource: "user",
                action: "update",
                callingMethod: "syncProfile",
                details: {
                    fullName: fullName,
                    avatar: avatar,
                    boxRole: boxRole,
                    boxTariff: boxTariff,
                    eid: eid,
                    boxEntName: boxEntName,
                    boxGroups: Groups,
                    lastSync: Date.now()
                },
                requester: Meteor.userId()
            }));

        }

        console.log("### END syncProfile METHOD ###");
    }, // end syncProfile method

}); // end all methods