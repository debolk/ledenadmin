class Bolk.OAuthRequest extends Bolk.AjaxRequest
	
	@EndPoint = "https://login.i.bolkhuis.nl/"
	
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OAuthRequest.EndPoint )
		super false, arguments...
	
	@getAccessToken: ( code ) ->
		params = {
			grant_type: 'authorization_code'
			code: code
			clientid: Bolk.clientId
			clientpass: Bolk.clientSecret
		}
		return new OAuthRequest 'token', params, 'post'