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
		state = Math.random().toString()
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
				
				locache.remove 'session_token_state' 
				
				if not cached_state or cached_state isnt state
					promise.reject "Wrong state! Did you make this request? #{ state } vs #{ cached_state } "
					return false
					
				Bolk.OAuthRequest.getAccessToken( code )
					.request
					.done( ( data ) =>
						console.info "token data: #{JSON.stringify(data)}"
						@token = data.access_token 
						locache.set 'session_token', data.access_token, data.expires_in - 60
						locache.set 'session_refresh_token', data.refresh_token, data.expires_in - 60
						promise.resolve @token
					).fail( ( error ) =>
						promise.reject error
					)
			)
		return promise.promise()
		
	# Kill the session
	#
	kill: () ->
		locache.remove 'session_token'
		locache.remove 'session_refresh_token'
		locache.flush()
	