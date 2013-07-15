class Bolk.OAuthRequest extends Bolk.AjaxRequest
	
	@EndPoint = 'https://#{Bolk.ClientId}:#{Bolk.ClientSecret}@login.i.bolkhuis.nl/'
	
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OAuthRequest.EndPoint )
		super false, arguments...
	
	@getAccessToken: ( code ) ->
		params = {
			grant_type: 'authorization_code'
			code: code
		}
		return new OAuthRequest 'post', params