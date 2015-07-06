Meteor.methods
	registerUser: (formData) ->
		userData =
			email: formData.email
			password: formData.pass

		userId = Accounts.createUser userData

		user = Meteor.users.findOne {_id: userId}
		console.log(user)
		if user.emails.address.includes '@42la.bs'
			Roles.addUsersToRoles user, ['admin'], '42labs'
			if Roles.usersIsInRole userId, 'admin', '42labs'
				console.log(user)
				console.log("wow")
		Meteor.users.update userId,
			$set:
				name: formData.name

		if userData.email
			Accounts.sendVerificationEmail(userId, userData.email);
