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
			<h1>Whiting</h1>
			</a>
		</div>
		<form class="form-inline" id="search">
			<div class="controls">
				<input id="search" type="text" class="input-big" placeholder="Search...">
			</div>
			<div class="actions">
				<a data-route="/new">Add member</a>
			</div>
		</form>
		</div>'

	#
	# Creates a dialog div
	#
	createDialog: ( description, title = "Warning!", style = "") ->
		return '<div class="alert ' + style + '">
		<button type="button" class="close" data-dismiss="alert">&times</button>
		<strong>' + title + '</strong> ' + description + '
		</div>'

	#
	# Creates an error div
	#
	createError: ( description ) ->
		@createDialog description, "Error!", "alert-error"

	#
	# Creates an error div
	#
	createSucces: ( description ) ->
		@createDialog description, "Succes!", "alert-success"
		
	# Fills the header template with a title
	#
	# @param title [String] the title
	#
	_fillHeader: ( title ) ->
		key = "header-#{ title.toLowerCase() }"
		template = locache.get( key )
		
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
			
