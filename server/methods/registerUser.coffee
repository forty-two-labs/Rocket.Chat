Meteor.methods
	registerUser: (formData) ->
		userData =
			email: formData.email
			password: formData.pass

		invite = Invites.findOne { token: formData.registerToken }

		unless invite.accountCreated

			userId = Accounts.createUser userData

			Invites.update
				_id: invite._id
			,
				$set:
					accountCreated: true
					userId: userId

			Meteor.users.update userId,
				$set:
					name: formData.name

			if userData.email
				Accounts.sendVerificationEmail(userId, userData.email);

		else
			{
				err: 'token used'
			}
