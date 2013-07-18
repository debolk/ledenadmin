# Class for all requests to the Oauth endpoint
#
class Bolk.OAuthRequest extends Bolk.AjaxRequest
	
	@EndPoint = "https://login.i.bolkhuis.nl/"
	
	# Creates a new OAuth request
	#
	# @param api [String] the api to invoke
	# @param params [Object] the parameters
	# @param method [String] the method to use
	#
	constructor: ->
		Object.defineProperty( @, 'endpoint', get: -> OAuthRequest.EndPoint )
		super false, arguments...
	
	# Gets a request that gets an access token
	#
	# @param code [String] code
	# @return [Bolk.OAuthRequest] the request
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
