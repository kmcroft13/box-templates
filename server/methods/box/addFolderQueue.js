Meteor.methods({

  'addFolderQueue'(folderId, folderName, boxUserId) {
    console.log("### ADD FOLDER TO QUEUE ###");
    check(folderId, Match.Any);
    check(folderName, Match.Any);
    check(boxUserId, Match.Any);

    //Remove all previous entries for this user in the queue
    const numRemoved = FolderQueue.remove({
        boxUserId: boxUserId
    });

    //Insert new entry for this user
    const newEntryId = FolderQueue.insert({
        folderName: folderName,
        folderId: folderId,
        boxUserId: boxUserId,
        addedAt: new Date()
    });

    let result = {};

    if (numRemoved > 0) {
        result = {
            resource: "folderQueue",
            action: "replace",
            details: {
                newEntryId: newEntryId,
                numRemoved: numRemoved
            }
        }
    } else {
        result = {
            resource: "folderQueue",
            action: "create",
            details: {
                newEntryId: newEntryId
            }
        }
    }

    console.log(JSON.stringify(result));
    return result;
  } //End addFolderQueue method
});
