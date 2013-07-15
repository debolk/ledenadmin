class Bolk.Session
	
	constructor: () ->
		@token = locache.get 'session_token'
		
		Object.defineProperty( @, 'isLoggedIn',
			get: -> return @token?
		)
	
	# Authenticate the client
	# 
	# @param cid [String] Client Id
	# @param secret [String] Client Secret
	# @param redirect [String] Redirect uri
	#
	oauth: ( cid = Bolk.clientId, secret = Bolk.clientSecret, redirect = "https://ledenadmin.i.bolkhuis.nl/" ) ->
		state = Math.random()
		locache.async.set( 'session_token_state', state )
			.finished( () ->
				window.location = "https://login.i.bolkhuis.nl/" + 
					"authorize?response_type=code" +
					"&state=#{state}" +
					"&client_id=#{cid}" +
					"&client_pass=#{secret}" +
					"&redirect_uri=#{redirect}"
			)
	
	# Login using the authorization code
	# 
	# @param code [String] auth code
	#
	login: ( code, state ) ->
		Bolk.OAuthRequest.getAccessToken( code )
			.execute()
			.done( ( data ) => 
				@token = data 
				locache.async.set 'session_token', data, 3500
			)
		
	# Kill the session
	#
	kill: () ->
		locache.remove 'session_token'
		locache.flush()
	