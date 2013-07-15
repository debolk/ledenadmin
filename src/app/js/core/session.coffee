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
		promise = jQuery.Deferred()
		
		locache.async.get( 'session_token_state' )
			.finished( ( cached_state ) =>
			
				if cached_state.toString() isnt state.toString()
					console.error 'Wrong state! Did you make this request?', state, cached_state
					return false
					
			
				Bolk.OAuthRequest.getAccessToken( code )
					.request
					.done( ( data ) =>
						console.info 'token is: ', data
						@token = data 
						locache.async.set 'session_token', data, 3500
						
						promise.resolve @token
					).fail( ( error ) =>
						console.error 'when getting token: ', error
						promise.reject error
					)
			)
		return promise.promise()
		
	# Kill the session
	#
	kill: () ->
		locache.remove 'session_token'
		locache.flush()
	