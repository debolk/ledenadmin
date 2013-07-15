# This is the controller class for the members listing pages. 
#
class Bolk.MembersPageController extends Bolk.PageController

	# Creates the controller for the Members Listing Page
	#
	# @param filter [String] the filter, defines the request type
	#
	constructor: ( @filter ) ->
		super new Bolk.MembersPage( @_titlefor @filter )
		
		# Lets see if we have members data
		locache.async.get( 'members-page' ).finished( ( data ) =>
			unless data
				@_fetchMembers()
			else
				@_parseMembers data
		)
		
	#
	#
	#
	_fetchMembers: () ->
		@showLoader()
		blip = new Bolk.BlipRequest 'members'
		blip.request.always( ( data ) =>
			@hideLoader()
			if blip.result
				locache.async.set 'members-page', blip.result, 120
				@_parseMembers blip.result 
		)
		
	#
	#
	#
	_parseMembers: ( data ) ->
		data = JSON.parse data if typeof data is String
		@model = new Bolk.Persons()
		for person in data
			@model.add new Bolk.Person( _.extend( person, { complete : true } ) )

		@view.display @model
		
	# Gets the title for a filter
	#
	# @param filter [String] the filter
	# @return [String] the title
	#
	_titlefor: ( filter ) ->
		switch filter
			when 'kandidaat'
				'Kandidaatleden'
			when 'oud'
				'Oud-leden'
			when 'actief'
				'Ledenlijst'
			else
				'Ledenlijst'
				