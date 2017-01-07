Meteor.methods({

  'renameContent'(findReplaceArray) {
    console.log("### BEGIN renameContent METHOD ###");
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
      console.log("Failed to get items from Box: " + JSON.stringify(getItems.error));
      throw Error( 500, 'There was an error processing the request to Box' );
    } else {
      containingFolderItems = getItems.result.entries;
    }


    for (let item of containingFolderItems) {
      var newName = item.name;

      for (let findReplace of findReplaceArray) {
        var find = new RegExp(findReplace.find,"g");
        var replace = findReplace.replace;
        var newName = newName.replace(find, replace);
      }
        if (item.name != newName) {
          if (item.type == "file") {
            box.files.update(item.id, {name : newName}, function(err, file) {
              if (err) {
                console.log(JSON.stringify({
                  item: item.id,
                  action: "skip",
                  details: {
                    status: "ERROR",
                    itemType: "file",
                    response: err
                  },
                  callingMethod: "renameContent"
                }));
              } else {
                console.log(JSON.stringify({
                  item: item.id,
                  action: "rename",
                  details: {
                    status: "SUCCESS",
                    itemType: "file",
                    oldName: item.name,
                    newName: file
                  },
                  callingMethod: "renameContent"
                }));
              }
            });
          } else { //is folder
            box.folders.update(item.id, {name : newName}, function(err, folder) {
              if (err) {
                console.log(JSON.stringify({
                  item: item.id,
                  action: "skip",
                  details: {
                    status: "ERROR",
                    itemType: "folder",
                    response: err
                  },
                  callingMethod: "renameContent"
                }));
              } else {
                console.log(JSON.stringify({
                  item: item.id,
                  action: "rename",
                  details: {
                    status: "SUCCESS",
                    itemType: "folder",
                    oldName: item.name,
                    newName: folder
                  },
                  callingMethod: "renameContent"
                }));
              }
            });
          }
      } else {
        console.log(JSON.stringify({
          item: item.name,
          action: "skip",
          details: "no match",
          callingMethod: "renameContent"
        }));
      }
    }

    console.log("### END renameContent METHOD ###");
  } //End renameContent method
});
