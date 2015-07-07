Meteor.startup ->
  unless process.env.NODE_ENV == 'production'
    process.env.MAIL_URL = Meteor.settings.MAIL_URL
