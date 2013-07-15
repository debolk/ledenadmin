# Base class for all pages. Provides functionality to use multiple views, create
# action lists, fill predefined templates and so forth and so on.
#
class Bolk.Page extends Bolk.ViewCollection
	
	# Creates a new page
	#
	# @param title [String] the title to display
	#
	constructor: ( title ) ->
		super 'body'

		@header = @container.find '#masthead'
		@contents = @container.find '#content'
		@footer = @container.find '#mastfoot'
		
		@_fillHeader title
		
	#
	#
	#
	_getHeaderTemplate: () ->
		'<div id="branding">
			<a name="home" data-route="<%= route_home %>">
				<img src="http://placehold.it/100x100.png">
			</a>
			<h1>Whiting</h1>
		</div>
		<form class="form-inline" id="search">
			<div class="controls">
				<input type="text" class="input-big" placeholder="Search...">
			</div>
			<div class="actions">
				<a data-route="/search/filter">Advanced filter</a> |
				<a data-route="/members/new">Add member</a>
			</div>
		</form>
		<div id="logout">
			<a data-route="/logout">
				<img src="http://placehold.it/100x100.png&text=logout">
			</a>
		</div>'
	
		
	# Fills the header template with a title
	#
	# @param title [String] the title
	#
	_fillHeader: ( title ) ->
		key = "header-#{ title.toLowerCase() }"
		locache.async.get( key ).finished ( template ) =>
			@header.hide()
			unless template
				template = _.template( @_getHeaderTemplate(), { route_home: '/home', title: title } )
				locache.async.set key, template, 3600
			@header.html( template )
			@header.fadeIn()
		
		
	# Clears the page
	#
	# @return [self] the chainable self
	#
	clear: () ->
		@header.empty()
		@contents.empty()
		return this
		
			
	showLoader: () ->
		
	hideLoader: () ->
			