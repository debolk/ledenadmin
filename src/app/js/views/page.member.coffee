# This is the view class for the member pages. 
#
class Bolk.MemberPage extends Bolk.Page
	
	# Creates a new view instance of the member page
	#
	# @param title [String] the title of the page
	#
	constructor: ( title = 'Member', uid, edit = false ) ->
		super title
		@uid = uid
		@el = $ '<form id="edit-member-' + uid + '" class="form-horizontal"></form>' 
		@contents.append @el

	#
	#
	#
	display: ( person ) ->
		@personView?.remove()
		@personView = new Bolk.PersonView( { el:  @el, model: person } )