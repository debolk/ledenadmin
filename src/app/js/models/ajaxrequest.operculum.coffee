class Bolk.OperculumRequest extends Bolk.AjaxRequest
	
	@EndPoint = '//operculum.i.bolkhuis.nl/'
	
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OperculumRequest.EndPoint )
		super arguments...