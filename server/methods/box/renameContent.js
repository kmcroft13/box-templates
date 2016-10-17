Meteor.methods({

  'renameContent'(findReplaceArray) {
    console.log("### STARTING RENAME ###");
    check(findReplaceArray, Match.Any);

    var userBoxId = Meteor.user().services.box.id;
    var containingFolder = FolderQueue.findOne({boxUserId: userBoxId}, {sort: {addedAt: -1}});
    var containingFolderItems;
    var tokenExpiration = Meteor.user().services.box.expiresAt;

    // CREATE CLIENT FOR BOX USER
    // Refresh token if needed
    if (Date.now() - tokenExpiration > 0) {
      console.log("Token Expired");
      refreshAccessToken = Meteor.myFunctions.refreshToken();
    }

    // Create client
    var accessToken = Meteor.user().services.box.accessToken;
    var box = sdk.getBasicClient(accessToken);
    console.log("Box Basic Client created: " + Meteor.user().profile.fullName);

    var getItems = Async.runSync(function(done) {
      box.folders.getItems(
          containingFolder.folderId,
          {
              fields: 'name,type,id',
              offset: 0,
              limit: 1000
          },
          function(err, folderItems) {
            done(err, folderItems);
          }
      )
    });


    if (getItems.error != undefined) {
      console.log("ERROR: getItems");
      console.log(JSON.stringify(getItems.error));
      throw Error( 500, 'There was an error processing the request to Box' );
    } else {
      containingFolderItems = getItems.result.entries;
    }


    for (let item of containingFolderItems) {
      console.log("Checking item: " + item.name);
      var newName = item.name;

      for (let findReplace of findReplaceArray) {
        var find = new RegExp(findReplace.find,"g");
        var replace = findReplace.replace;
        var newName = newName.replace(find, replace);
      }
        if (item.name != newName) {
        console.log("MATCH: Rename Box " + item.type + " (" + item.id + ") to: " + newName + "...");
        if (item.type == "file") {
          box.files.update(item.id, {name : newName}, function(err, file) {
            if (err)
              console.log("ERROR: " + JSON.stringify(err));
            else
              console.log("FILE RENAMED: " + JSON.stringify(file));
          });
        } else { //is folder
          box.folders.update(item.id, {name : newName}, function(err, folder) {
            if (err)
              console.log("ERROR: " + JSON.stringify(err));
            else
              console.log("FOLDER RENAMED: " + JSON.stringify(folder));
          });
        }
      }
    }

    console.log("### FINISHING RENAME ###")
  } //End renameContent method
});
