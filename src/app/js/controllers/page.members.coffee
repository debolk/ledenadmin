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
				@_displayMembers data
		)
		
	#
	#
	#
	_fetchMembers: () ->
		blip = new Bolk.BlipRequest 'members'
		blip.request.always( ( data ) =>
			console.log blip.result
			_displayMembers blip.result if blip.result
		)
		
	#
	#
	#
	_displayMembers: ( collection ) ->
		#create view for collection
		
		
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
				