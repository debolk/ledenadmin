class Bolk.OperculumRequest extends Bolk.AjaxRequest
	
	@EndPoint = 'http://operculum.i.bolkhuis.nl/'
	
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OperculumRequest.EndPoint )
		super true, arguments...