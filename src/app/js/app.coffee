class Bolk.AppRouter extends Backbone.Router 
	
	# Defines the routes for this application
	#
	routes: {
		''				: 'home'
		'home'			: 'home'
		'leden'			: 'members'
		'leden/:filter' 	: 'members'
		'lid/:id' 		: 'member'
	}
	
	# Initializes the router
	#
	initialize: ->
		@controller = null
		Backbone.history.start()
		#Backbone.history.start({pushState: true, root: "/public/search/"}
		console.debug 'Finished initializing router'
		
	# Routes the home page
	#
	home: ->
		console.debug 'Routing home'
		@controller?.kill()
		@controller = new Bolk.HomePageController()
		
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