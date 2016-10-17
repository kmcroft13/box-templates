Meteor.myFunctions = {

    refreshToken: function () {
        const config = ServiceConfiguration.configurations.findOne({service: 'box'});
        if (!config) {
            throw new ServiceConfiguration.ConfigError();
        }

        console.log("Trying to exchange Refresh Token...");

        const refreshToken = Meteor.user().services.box.refreshToken;
        console.log(refreshToken);

        const apiUrl = "https://api.box.com/oauth2/token";
        const result = HTTP.post(apiUrl, {
            params: {
                client_id: config.appId,
                client_secret: config.secret,
                refresh_token: refreshToken,
                grant_type: 'refresh_token'
            }
        });

        if (result.data.access_token) {
            Meteor.users.update({_id: Meteor.userId()}, {
                $set: {
                    'services.box.accessToken': result.data.access_token,
                    'services.box.expiresAt': (+new Date) + (1000 * result.data.expires_in),
                    'services.box.refreshToken': result.data.refresh_token
                }
            });

            console.log("Success! New access token...");
            console.log(result.data.access_token);
            console.log("Proceeding with call to Box API");
        }
    },


    renameContent2: function (itemsCopyResults, findReplaceArray, accessToken) {
        console.log("### STARTING RENAME ###");
        check(itemsCopyResults, Match.Any);
        check(findReplaceArray, Match.Any);
        check(accessToken, Match.Any);
        var containingFolderItems;
        // CREATE CLIENT FOR BOX USER
        const box = sdk.getBasicClient(accessToken);
        console.log("Box Basic Client created: " + Meteor.user().profile.fullName);
        // declare function to get items from Box
        function getFolderItems(parentId) {
            return Async.runSync(function (done) {
                box.folders.getItems(
                    parentId,
                    {
                        fields: 'name,type,id',
                        offset: 0,
                        limit: 1000
                    },
                    function (err, folderItems) {
                        done(err, folderItems);
                    }
                )
            });
        }
        for (let itemResult of itemsCopyResults) {
            const parentId = itemResult.id;
            const parentStatus = itemResult.type;
            console.log(parentStatus);
            if (parentStatus == "success" || parentStatus == "success with conflict") {
                const getItems = getFolderItems(parentId);
                console.log(getItems);
                if (getItems.error != undefined) {
                    console.log("ERROR: getItems");
                    console.log(JSON.stringify(getItems.error));
                    throw Error(500, 'There was an error processing the request to Box');
                } else {
                    containingFolderItems = getItems.result.entries;
                }
                for (let item of containingFolderItems) {
                    console.log("Checking item: " + item.name);
                    var newName = item.name;
                    for (let findReplace of findReplaceArray) {
                        var find = new RegExp(findReplace.find, "g");
                        var replace = findReplace.replace;
                        newName = newName.replace(find, replace);
                    }
                    if (item.name != newName) {
                        console.log("MATCH: Rename Box " + item.type + " (" + item.id + ") to: " + newName + "...");
                        if (item.type == "file") {
                            box.files.update(item.id, {name: newName}, function (err, file) {
                                if (err)
                                    console.log("ERROR: " + JSON.stringify(err));
                                else
                                    console.log("FILE RENAMED: " + JSON.stringify(file));
                            });
                        } else { //is folder
                            box.folders.update(item.id, {name: newName}, function (err, folder) {
                                if (err)
                                    console.log("ERROR: " + JSON.stringify(err));
                                else
                                    console.log("FOLDER RENAMED: " + JSON.stringify(folder));
                            });
                        }
                    }
                } // end for loop of containingFolderItems
            } // end if itemStatus type success
        } // end for loop of itemsCopyResult
        console.log("### FINISHING RENAME ###")
    } // end renameContent method
}; // end myFunctions
