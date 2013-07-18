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
		@container = @container.find '#content'
		@container.append ( @errors = $ '<div id="errors"></div>' )
		@container.append ( @loading = $ '<div id="loader"></div>' )
		@container.append ( @contents = $ '<div id="contents"></div>' )
		@footer = @container.find '#mastfoot'
		
		@_fillHeader title
		
	# Gets the header template
	#
	#
	_getHeaderTemplate: () ->
		'<div id="branding">
			<a name="home" data-route="<%= route_home %>">
				<img src="app/img/logo.png">
			<h1>Whiting</h1>
			</a>
		</div>
		<form class="form-inline" id="search">
			<div class="controls">
				<input id="search-field" type="text" class="input-big" placeholder="Search...">
			</div>
			<div class="actions">
				<a data-route="/new">Add member</a>
			</div>
		</form>
		'
			
	# Shows the loader
	#
	# @return [self] the chainable self
	#
	showLoader: () ->
		@loading.html( $ "<div>Loading...</div>" )
		
		return this
		
	# Hides the loader
	#
	# @return [self] the chainable self
	#
	hideLoader: () ->	
		@loading.empty()
		
	# Creates a alert div
	#
	# @param description [String] the alert message
	# @param title [String] the title message
	# @param style [String] the style
	# @return [jQuery.Elem] the element 
	#
	createAlert: ( description, title = "Warning!", style = "") ->
		$ "<div class='alert #{ style }'>
			<button type='button' class='close' data-dismiss='alert'>&times</button>
			<strong>#{ title }</strong> #{ description }
		</div>"

	# Creates an error div
	#
	# @param description [String] the error message
	# @return [jQuery.Elem] the element 
	#
	createError: ( description ) ->
		@createAlert description, "Error!", "alert-error"

	# Creates a success div
	#
	# @param description [String] the success message
	# @return [jQuery.Elem] the element 
	#
	createSuccess: ( description ) ->
		@createAlert description, "Succes!", "alert-success"
		
	# Clears all errors
	#
	# @return [self] the chainable self
	#
	clearErrors: ->
		@errors.empty()
		return this
	
	# Show a success message
	#
	# @param description [String] the success message
	# @return [self] the chainable self
	#
	showSuccess: ->
		@errors.append( @createSuccess arguments... )
		return this
		
	# Show an error message
	#
	# @param description [String] the error message
	# @return [self] the chainable self
	#
	showError: ->
		@errors.append( @createError arguments... )
		
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
		@container.empty()
		return this
			
