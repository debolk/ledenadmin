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
		@headerTemplate = 
		
		@header = @container.find '#masthead'
		@contents = @container.find '#content'
		@footer = @container.find '#mastfoot'
		
		@_fillHeader title
		
	#
	#
	#
	_getHeaderTemplate: () ->
		'<div id="branding">
			<a href="#<%= route_home %>" data-route="<%= route_home %>">
				<img src="//placehold.it/100x100.png">
			</a>
			<h1>Whiting</h1>
		</div>
		<form class="form-inline" id="search">
			<div class="controls">
				<input type="text" class="input-big" placeholder="Search...">
			</div>
			<div class="actions">
				<a href="#/search/filter" data-route="/search/filter">Advanced filter</a> |
				<a href="#/members/new" data-route="/members/new">Add member</a>
			</div>
		</form>
		<div id="logout">
			<a href="#/logout" data-route="/logout">
				<img src="//placehold.it/100x100.png&text=logout">
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
				locache.async.set key, template
			@header.html( template )
			@header.fadeIn()
		
	# Creates a list of actions
	#
	# @param actions [Array<Object>] a list of actions
	# @return [String] the ul HTML with all the links
	#
	_createActions: ( actions ) ->
		templ = '<a href="#<%= link %>" data-route="<%= link %>"><%= text %></a>' 
		result = $ '<ul></ul>'
		for action in actions
			result.append( 
				$( '<li></li>' ).html(
					_.template( templ, action )
				)
			)
		return result
		
	# Clears the page
	#
	#
	clear: () ->
		@header.empty()
		@contents.empty()
			