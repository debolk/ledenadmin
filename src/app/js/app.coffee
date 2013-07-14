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
		'?code=:code'		: 'login'
	}
	
	# Initializes the router
	#
	initialize: ->
		@controller = null
		@session = new Bolk.Session()
		Backbone.history.start()
		#Backbone.history.start({pushState: true, root: "/public/search/"}
		console.debug 'Finished initializing router'
		
		# TODO: check for session
		# if needed @session.oauth()
		
	# Routes the members pages
	#
	# @param filter [String] the filter to use for the members
	#
	members: ( filter = 'actief' ) ->	
		console.debug 'Routing members - ' + filter
		@controller?.kill()
		@controller = new Bolk.MembersPageController filter
	
	# Routes the member page
	#
	# @param member [String] the member id to route to
	#
	member: ( id ) ->
		console.debug 'Routing member:' + id
		@controller?.kill()
		@controller = new Bolk.MemberPageController id
		
	#
	#
	#
	#
	search: ( action = null ) ->
		console.debug "Routing search: #{ if action is 'filter' then 'advanced' else 'normal'}"
		@controller?.kill()
		@controller = new Bolk.SearchPageController action is 'filter'
	
	#
	#
	#
	login: ( code ) ->
		@session.login code, @session.token
	
	#
	#
	#
	logout: ->
		@session.kill()
		@navigate '/home', { trigger: true, replace: true }
			