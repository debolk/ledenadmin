class Bolk.OAuthRequest extends Bolk.AjaxRequest
	
	@EndPoint = "https://login.i.bolkhuis.nl/"
	
	#
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OAuthRequest.EndPoint )
		super false, arguments...
	
	#
	#
	#
	#
	@getAccessToken: ( code ) ->
		params = {
			grant_type: 'authorization_code'
			code: code
			client_id: Bolk.clientId
			client_secret: Bolk.clientSecret
			redirect_uri: Bolk.baseUrl
		}
		return new OAuthRequest 'token', params, 'post'
