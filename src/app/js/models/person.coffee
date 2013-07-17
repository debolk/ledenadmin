#
#
class Bolk.Person extends Backbone.Model
	
	constructor: (data) ->
		super data
		@index = JSON.stringify data
		@index = @index.replace '"', '', 'g'
		@index = @index.toLowerCase()

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
		initials: ''
		firstname: ''
		lastname: ''
		email: ''
		gender: ''
		phone: ''
		mobile: ''
		phone_parents: ''
		address: ''
		dateofbirth: ''
	}

		
