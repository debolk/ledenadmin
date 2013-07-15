# This is the view class for the member pages. 
#
class Bolk.MemberPage extends Bolk.Page
	
	# Creates a new view instance of the member page
	#
	# @param title [String] the title of the page
	#
	constructor: ( title = 'Member', edit = false ) ->
		super title
		@content.append ( @el = $ '<form class="form-horizontal"></form>' )
	
	display: ( person ) ->
		@personView?.remove()
		@personView = new Bolk.PersonView( { el:  @el, model: person } )