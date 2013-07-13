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
		@headerTemplate = '<%= title %>'
		
		@header = @container.find '#masthead'
		@contents = @container.find '#content'
		@footer = @container.find '#mastfoot'
		
		@_fillHeader title
		
	# Fills the header template with a title
	#
	# @param title [String] the title
	#
	_fillHeader: ( title ) ->
		@header.html _.template( @headerTemplate, { title: title } )
		
	# Creates a list of actions
	#
	# @param actions [Array<Object>] a list of actions
	# @return [String] the ul HTML with all the links
	#
	_createActions: ( actions ) ->
		templ = '<a href="<%= link %>"><%= text %></a>' 
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
			