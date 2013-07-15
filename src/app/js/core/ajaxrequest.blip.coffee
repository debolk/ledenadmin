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
		@result = data