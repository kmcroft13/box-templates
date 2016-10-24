Router.route('/folderqueue', function () {
    console.log("Begin controllerFolderQueue...");
    const folderId = this.request.body.folder_id
    const folderName = this.request.body.folder_name
    const userId = this.request.body.box_id

    let statusCode = 404;

    Meteor.call('controllerFolderQueue', folderId, folderName, userId, (err, res) => {
        if (err) {
            console.log("Error. Nothing added to queue. " + err)
            statusCode = 400;
            const errorString = err.toString().replace("Error: ", "");
            responseJSON = {
                status: "400", 
                error: {
                    reason: "missing_folder_info", 
                    message: errorString
                }
            };

        } else {
            console.log("Success! Folder submitted to queue: " + res)
            statusCode = 200;
            const resultString = res.toString();
            responseJSON = {
                status: "204", 
                data: {
                    id: resultString,
                    message: "Folder submitted to queue"
                }
            };
        }
    });

    this.response.writeHead(statusCode, {"Content-Type": "application/json"});
    this.response.end(JSON.stringify(responseJSON));

}, {where: 'server'});
