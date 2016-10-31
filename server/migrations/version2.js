Migrations.add({
  version: 2,
  name: 'Add dynamicRename and sharing section to existing Templates',
  up: function() {
      //code to migrate up to version 2
        Template.update({ "dynamicRename": {$in: [null, false]} }, {
            $set: {
                dynamicRename: { isUsing: false},
                sharing: { shared: false }
            }
        });
      },
  down: function() {
      //code to migrate down to version 1
        Template.update({ $or: [ "dynamicRename": {$exists: true}, "sharing": {$exists: true} ] }, {
            $unset: {
                dynamicRename: "",
                sharing: ""
            }
        });
  }
});