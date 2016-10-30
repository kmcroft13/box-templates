Router.route('/folderqueue', function () {
    console.log("Calling addFolderQueue...");
    const folderId = this.request.body.folder_id
    const folderName = this.request.body.folder_name
    const userId = this.request.body.box_id

    let statusCode = 404;
    let responseJSON = {};

    Meteor.call('addFolderQueue', folderId, folderName, userId, (err, res) => {
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
            statusCode = 200;
            responseJSON = {
                status: "204", 
                data: res
            };
        }
    });

    this.response.writeHead(statusCode, {"Content-Type": "application/json"});
    this.response.end(JSON.stringify(responseJSON));

}, {where: 'server'});
