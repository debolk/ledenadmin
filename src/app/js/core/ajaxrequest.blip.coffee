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
	onSuccess: ( data ) =>
		switch @api
			when 'members'
				data = JSON.parse data if typeof data is String
				@result = new Bolk.Persons()
				for person in data
					@result.add new Bolk.Person( _.extend( person, { complete : true } ) )
			else
				@result = data