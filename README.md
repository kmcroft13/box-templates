# Box Templates

Integration with the Box web application that enables users to create templates
of files and folder and copy them into other folders as needed. The integration launches
from the **target** folder, rather than from the source folder, allowing users
to create content directly in the target folder without visiting the source files individually first.

##Box App
Go to developers.box.com to create your Box application. This is required for the login and integrations to works properly. Once you create the app, you will need to use the client ID and secret to create a Meteor settings file.

###Settings file
You will need to create a Meteor settings.json file and [start your app with it](http://docs.meteor.com/commandline.html#meteordeploy) to initialize the connection with your Box app (among a few other things). Your settings file should look like the one below:

```JSON
{
  "public": {
    "environment" : "<ENVIRONMENT_CODE>"
  },
  "orion-cli": {
    "profile": "coffee",
    "config": "private/orion-config.json"
  },
  "email": {
    "sendinblueKey": "<TRANSACTIONAL_EMAIL_SERVICE_KEY"
  },
  "serviceConfigurations": {
    "box": {
      "appId": "<BOX_APP_CLIENT_ID>",
      "secret": "<BOX_APP_SECRET>"
      }
  }
}
```

####Environment
Can be either "dev", "stage", or "prod"
Allows the app to have different behavior depending on the environment (ie. if you have a test folder in Box you want to use for the Dev environment)
####Orion
The `orion-cli` section refers to the Orion scaffolding and dev tools that are packaged with this app
Profile can be either "es6" or "coffee" depending on whether you want to use traditional javascript or coffee script files (I prefer coffee script)
Visit the [Orion-CLI GitHub](https://github.com/matteodem/orion-cli) for more info
####Service Configurations
This is where you put the API keys and secrets of any apps you want to integrate with. Each additional integration should be a child object of `serviceConfigurations`. In this case, we only have Box so we take the client ID and secret from the Box app page and put them here.
####Email
This app uses transactional email service SendInBlue to send emails to new users when their accounts are created.
You can sign up with a transactional email account with SendInBlue (it's free!) or modify the code in  `server/lib/onCreateUser.js` to switch to the service of your choice (or remove this feature entirely).


## TODO
Keeping track of things I want to add in the future!

####SHORT TERM

####MID TERM
+ Make existing Templates editable
  + Allow adding and removing individual items from Templates
+ Standardize colors (specifically the blues)

####LONG TERM
+ Dynamic renaming
   + Rename throughout structure? Only certain levels?
+ Enterprise / Group templates
   + Check if group has access to folder before creating (throw warning if not?)

####BACKLOG
+ Create sample folder structure template. Share with other Boxers?
+ Figure out why yogiben:admin package isn't working
+ Update Account templates like signIn and ensureSignedIn



####COMPLETED
+ Add code to clean up FolderQueue objects so that only the most recent one remains (**_COMPLETE_**)
+ Allow multiple items to be copied into the same folder (automatically rename) (**_COMPLETE_**)
+ Standardize labels (**_COMPLETE_**)
  + Widths and padding need to be set with CSS
+ Scrolling (**_COMPLETE_**) (I think)
   + Use FP destroy() to make pages scrollable OR  <- this option was chosen for now
   + Add scroll bars to each section and auto-calculate section size
+ Update home page slide 2 (**_COMPLETE_**)
+ Make feedback button expand to say "Submit Feedback" instead of label, and add close button (**_COMPLETE_**)
+ Fix bug when changing dropdown items on "Copy" page (**_COMPLETE_**)
