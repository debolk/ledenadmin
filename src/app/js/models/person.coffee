#
#
class Bolk.Person extends Backbone.Model
	
	constructor: (data) ->
		super data
		regex = new RegExp '"', 'g'
		@index = JSON.stringify data
		@index = @index.replace regex, ''
		@index = @index.toLowerCase()

	matches: (filter) ->
		satisfies = (heap, words) ->
			for word in words
				if heap.indexOf(word) == -1
					return false
			return true

		for andclause in filter
			satisfied = false
			for orclause in andclause
				if satisfies @index, orclause
					satisfied = true
					break
			if not satisfied
				return false
		return true

	merge_operculum: ( finish = -> {} ) ->
		if @complete
			finish()
			return
		operculum = new Bolk.OperculumRequest "person/#{@attributes.uid}"
		model = this
		operculum.request.done ( data ) ->
			model.set(data)
			model.complete = true
			locache.async.set( 'member-page-' + model.attributes.uid, model.attributes )
			finish()
		operculum.request.fail ->
			model.complete = true
			finish()

	to_csv: ->
		line = ""
		first = true
		r = new RegExp '"', 'g'
		for key, value of @attributes
			value = value ? ""

			escaped = value
			if typeof(escaped) == 'string'
				escaped = escaped.replace r, '""' 

			line += ',' unless first
			first = false

			if escaped
				line += '"' + escaped + '"'
		line

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

		
