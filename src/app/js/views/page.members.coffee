# This is the view class for the members listing pages. 
#
class Bolk.MembersPage extends Bolk.Page
	
	# Creates a new view instance of the members page
	#
	# @param title [String] the title of the page
	#
	constructor: ( title = 'Members' ) ->
		super title