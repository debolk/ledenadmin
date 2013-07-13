# This is the view class for the members listing pages. 
#
class Bolk.MembersPage extends Bolk.Page
	
	# Creates a new view instance of the members page
	#
	# @param title [String] the title of the page
	#
	constructor: ( title = 'Ledenlijst' ) ->
		super title
		
		actions = []
		actions.push { link: '/home', text: 'Home' }
		actions.push { link: '/leden/oud', text: 'Oud-leden' }
		actions.push { link: '/leden/kandidaat', text: 'Kandidaatleden' }
		
		@contents.append( @_createActions actions )