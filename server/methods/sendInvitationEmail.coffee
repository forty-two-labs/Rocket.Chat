Meteor.methods
	sendInvitationEmail: (email, url, rid) ->
	  token = Random.hexString(20)

	  invitee =
	    email: email
	    rid: rid
	    token: token
	    dateInvited: (new Date).getTime()
	    accountCreated: false
	  Invite.insert invitee, (error) ->
	    if error
	      console.log error
	    else
	      Email.send
	        to: invitee.email
	        from: 'Yo from 42Labs <someone@42la.bs>'
	        subject: 'Yo from 42Labs!'
	        html: Handlebars.templates['send-invite'](
	          token: token
	          url: url
	          urlWithToken: url + '/' + token)
