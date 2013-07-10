class Bolk.OAuthRequest extends Bolk.AjaxRequest
	
	@EndPoint = '//login.i.bolkhuis.nl/'
	
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OAuthRequest.EndPoint )
		super arguments...
	