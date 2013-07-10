class Bolk.BlipRequest extends Bolk.AjaxRequest

	@EndPoint = '//blip.i.bolkhuis.nl/'
	
	#
	#
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> BlipRequest.EndPoint )
		super arguments...
	
	#
	#
	#
	onSuccess: ( data ) ->
		