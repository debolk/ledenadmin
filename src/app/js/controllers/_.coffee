# The base of all controllers
#
class Bolk.Controller 
	
	# Creates the controller
	#
	# @param view [View.*] the view
	#
	constructor: ( @view ) ->
		@_children = {}
		
	# Adds a child controller
	#
	# @param id [String] the id of the controller
	# @param controller [Controller.*] the controller
	# @return [self] the chainable self
	#
	addChild: ( id, controller ) ->
		@_children[ id ] = controller
		return this
			
	# Remove a child controller
	# 
	# @param id [String] the id of the controller to remove
	# @param kill [Boolean] kill on remove
	# @return [self] the chainable self
	#
	removeChild: ( id, kill = on ) ->
		@_children[ id ]?.kill() if kill
		delete @_children[ id ] 
		return this
		
	#
	#
	each: ( func ) ->
		_.each( @_children, func )
		
	# Gets the controller with the id
	# 
	# @param id [String] the id to get
	# @return [Controller.*] the controller
	#
	controller: ( id ) ->
		return @_children[ id ]
		
	# Returns all the controllers
	#
	# @return [Array<Controller.Base>] The controllers
	#
	controllers: () ->
		return @_children
		
	# Finds the key of a controller
	# 
	# @param func [Function] function to evaluate a value
	# @return [String] the key
	# 
	findKey: ( func ) ->
		result = null
		if _.find( @controllers(),  ( v, key ) -> 
					result = key
					return func v )
			return result
		return null
		
	# Kills the controler and all subsequent views
	#
	# @return [self] the chainable self
	#
	kill: () ->
		@removeChild( id, on ) for id, child of @_children
		@view?.kill()
		return this
		
	# Runs when the user tries to unload the page
	#
	beforeUnload: () ->
		return undefined
		
	# Runs when the user has unloaded the page
	#
	onUnload: () ->
		@each( ( child ) -> child.onUnload() )
		return undefined
