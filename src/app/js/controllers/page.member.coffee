# This is the controller class for the members listing pages. 
#
class Bolk.MemberPageController extends Bolk.PageController

	# Creates the controller for the Members Listing Page
	#
	# @param filter [String] the filter, defines the request type
	#
	constructor: ( @uid ) ->
		super new Bolk.MemberPage( 'member-' + @id )
		
		# Lets see if we have members data
		locache.async.get( 'member-page' ).finished( ( data ) =>
			unless data
				@_fetchMember()
			else
				@_displayMember data
		)
		
	#
	#
	#
	_fetchMember: () ->
		blip = new Bolk.BlipRequest "persons/#{@uid}"
		blip.request.done( ( blipdata ) =>
		
			# merge with operculum
			operculum = new Bolk.OperculumRequest "persons/#{@uid}"
			operculum.request.done( ( operculumdata ) =>
				console.log data = new Bolk.Person( _.extend( operculumdata, blipdata, { completed: true } ) )
				@_displayMember data
			)
		)
		
		# TODO: hack
		@view.contents.append ( el = $ '<form class="form-horizontal"></form>' )
		v = new Bolk.PersonView( el: el, model: new Bolk.Person() ).render()
		
	#
	#
	#
	_displayMember: ( model ) ->
		# create view from model
				