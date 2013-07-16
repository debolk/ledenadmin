class Bolk.OperculumRequest extends Bolk.AjaxRequest
	
	@EndPoint = 'https://operculum.i.bolkhuis.nl/'
	
	#
	#
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OperculumRequest.EndPoint )
		super true, arguments...
		
	#
	#
	#
	onSuccess: ( data ) =>
		@result = data
