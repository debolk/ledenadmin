class Bolk.BlipRequest extends Bolk.AjaxRequest

	@EndPoint = 'http://blip.i.bolkhuis.nl/'
	
	#
	#
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> BlipRequest.EndPoint )
		super true, arguments...
	
	#
	#
	#
	onSuccess: ( data ) ->
		switch @api
			when '/members'
				@result = @JSONToMembers data
			else
				@result = data
	
	#
	#
	#
	JSONtoMembers: ( json ) ->
		result = new Bolk.Persons()
		for person in json
			result.add new Bolk.Person( _.extend( person, { complete : true } ) )
		return result