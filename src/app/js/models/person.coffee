#
#
class Bolk.Person extends Backbone.Model

	defaults: {
		uid: ''
		
		# operculum
		nickname: ''
		study: ''
		alive: true
		inauguration: null
		resignation_letter: null
		resignation: null
		
		#blip
		firstname: ''
		lastname: ''
		email: ''
		mobile: ''
		phone: ''
		phone_parents: ''
		address: ''
	}

		