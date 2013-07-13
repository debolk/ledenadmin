class Bolk.ViewCollection

	# Creates a collection of views
	#
	# @param id [String] The id of the container for the views
	#
	constructor: ( @id ) ->
		if @id?
			@container = $( id )

		@_views = []
	
	# Clears the collection
	#
	clear: () ->
		view.clear() for view in @_views
		return this
	
	# Kills the collection
	#
	# @param reset [Boolean] if true, clears the internal array
	#
	kill: ( reset = off ) ->
		@clear()
		view.kill?() for view in @_views
		@_views = [] if reset
		return this
		
	# Add a view to draw
	#
	# @param view [View.*] the view to add
	#
	add: ( view, draw = on ) ->
		@_views.push view
		view.draw() if draw
		return this
		
	# Removes the view
	#
	# @param view [View.*] the view to remove
	#
	remove: ( view ) ->
		@_views = _.without( @_views, view )
		return this
		
	# Draw ths collection
	#
	draw: () ->
		view.draw() for view in @_views	
		return this
		
	# Redraws this collection
	#
	redraw: () ->
		view.redraw() for view in @_views
		return this
		
	#
	#
	each: ( func ) ->
		_.each( @_views, func )