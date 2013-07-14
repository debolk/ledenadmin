# This is the view class for the search pages. 
#
class Bolk.SearchPage extends Bolk.Page
	
	# Creates a new view instance of the member page
	#
	# @param title [String] the title of the page
	#
	constructor: ( title = 'Search', advanced = false ) ->
		super title