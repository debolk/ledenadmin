# The Application router maps all URLS to controllers
#
class Bolk.AppRouter extends Backbone.Router 
	
	# Defines the routes for this application
	#
	routes: {
		''				: 'members'
		'home'			: 'members'
		'members'		: 'members'
		'members/:filter' : 'members'
		'member/:id' 		: 'member'
		'search'			: 'search'
		'search/:action'	: 'search'
		'logout'			: 'logout'
		'?code=:code&state=:state' : 'getToken'
		'login'			: 'oauth'
	}
	
	# Initializes the router
	#
	initialize: ->
		@controller = null
		@session = new Bolk.Session()
		Backbone.history.start()
		#Backbone.history.start({pushState: true, root: "/public/search/"}
		console.debug 'Finished initializing router'

	# Routes the members pages
	#
	# @param filter [String] the filter to use for the members
	#
	members: ( filter = 'actief' ) ->
		console.debug 'Routing members - ' + filter
		@controller?.kill()
		return unless @ensureSession()
		@controller = new Bolk.MembersPageController filter
	
	# Routes the member page
	#
	# @param member [String] the member id to route to
	#
	member: ( id ) ->
		console.debug 'Routing member:' + id
		@controller?.kill()
		return unless @ensureSession()
		@controller = new Bolk.MemberPageController id
		
	# Routes the search page
	#
	# @param action [String] the action for the search page
	#
	search: ( action = null ) ->
		console.debug "Routing search: #{ if action is 'filter' then 'advanced' else 'normal'}"
		@controller?.kill()
		return unless @ensureSession()
		@controller = new Bolk.SearchPageController action is 'filter'
	
	# Routes to the oauth login page
	#
	oauth: ->
		@session.oauth()

	# Logs in after receiving a code
	# 
	# @param code [String] the authentication code
	#
	getToken: ( code, state ) ->
		console.debug "Logging in " + state + " vs " + locache.get 'session_token_state'
		@session.login( code, state ).done( =>
			@navigate '//home', { trigger: true, replace: true }
		)
	
	# Logs out
	#
	#
	logout: ->
		console.debug "Logging out"
		@session.kill()
		@navigate '//home', { trigger: true, replace: true }
		
	# Ensures a user to be logged in
	#
	ensureSession: () ->
		if ( code = @get( 'code' ) ) and ( state = @get( 'state' ) )
			@getToken code, state
			return false
		unless @session.isLoggedIn
			@session.oauth()
			return false
		return true
		
	#
	#
	#
	get: ( name ) ->
		name = name.replace( /[\[]/, "\\\[" ).replace( /[\]]/, "\\\]" )
		expression = new RegExp( "[\\?&]#{name}=([^&#]*)" )
		if results = expression.exec( location.search )
			if results[ 1 ]?
				return decodeURIComponent( results[ 1 ].replace( /\+/g, " ") )
		return undefined
			