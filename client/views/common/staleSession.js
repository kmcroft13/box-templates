Template.staleSession.events({

    'click #at-box' : function(){
        // Meteor.loginWithBox() function
        Meteor.loginWithBox(function(err){
            if (err) {
                console.log(err);
            }
            // The user might not have been found, or their password
            // could be incorrect. Inform the user that their
            // login attempt has failed.
            else {
                console.log("Logged in");
                Router.go('home');
            }
            // The user has been logged in.
        });
        return false;
    }
});