class Bolk.Session
	
	constructor: () ->
		@token = locache.get 'token'
	
	# Authenticate the client
	# 
	# @param cid [String] Client Id
	# @param secret [String] Client Secret
	# @param redirect [String] Redirect uri
	#
	oauth: ( cid = Bolk.clientId, secret = Bolk.clientSecret, redirect = "http://ledenadmin.i.bolkhuis.nl/#/" ) ->
		window.location = "https://login.i.bolkhuis.com/" + 
			"authorize?client_id=#{cid}&client_pass=#{secret}&redirect_uri=#{redirect}"
	
	# Login using the authorization code
	# 
	# @param code [String] auth code
	#
	login: ( code ) ->
		Bolk.OAuthRequest.getAccessToken( code )
			.execute()
			.done( ( data ) => @token = data )
		
	# Kill the session
	#
	kill: () ->
		locache.remove 'token'
		locache.flush()
	