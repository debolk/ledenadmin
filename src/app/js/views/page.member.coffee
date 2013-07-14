# This is the view class for the member pages. 
#
class Bolk.MemberPage extends Bolk.Page
	
	# Creates a new view instance of the member page
	#
	# @param title [String] the title of the page
	#
	constructor: ( title = 'Members', edit = false ) ->
		super title