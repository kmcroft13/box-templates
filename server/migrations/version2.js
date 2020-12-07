Migrations.add({
  version: 2,
  name: 'Add dynamicRename and sharing section to existing Templates',
  up: function() {
      //code to migrate up to version 2
        const result = Template.update({ "dynamicRename": {$in: [null, false]} }, {
            $set: {
                dynamicRename: { isUsing: false},
                sharing: { shared: false }
            }
        },
        { multi: true }
        );

        console.log(result);
      },
  down: function() {

  }
});