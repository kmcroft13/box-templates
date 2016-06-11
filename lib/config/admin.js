AdminConfig = {
  adminEmails: ['k.croft@me.com','kcroft@box.com','kcroft+demo@box.com'],
  collections: {
    Template: {
      color: 'green',
      extraFields: ['owner'],
      tableColumns: [
        { label: 'Name', name:'name' },
        { label: 'Creator', name:'creator()', template: 'adminUserCell' }
      ]
    },
    FolderQueue: {
      color: 'yellow',
      extraFields: ['owner'],
      tableColumns: [
        { label: 'Box User', name:'boxUserId' },
        { label: 'Folder Name', name:'folderName' }
      ]
    }
  }
};

Houston.add_collection(Meteor.users);
