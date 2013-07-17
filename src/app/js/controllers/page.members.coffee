# This is the controller class for the members listing pages. 
#
class Bolk.MembersPageController extends Bolk.PageController

	@CacheTime = 120

	# Creates the controller for the Members Listing Page
	#
	# @param filter [String] the filter, defines the request type
	#
	constructor: ( @filter ) ->
		super new Bolk.MembersPage( @_titlefor @filter )

		console.log @filter
		
		# Lets see if we have members data
		locache.async.get( 'members-page' ).finished( ( data ) =>
			unless data
				@_fetchMembers()
			else
				@_parseMembers data
		)

		# Bind to search form
		controller = this
		@search = $ 'input#search'
		@search.keyup ->
			controller.filter = controller.search.val().toLowerCase()
			if(controller.filter.length < 3)
				console.log controller.model
				if controller.view.collectionView.model != controller.model
					controller.view.display controller.model
				return

			controller.selection = new Bolk.Persons()
			console.log controller.filter
			for person in controller.model.models
				console.debug person.index.indexOf(controller.filter)
				if person.index.indexOf(controller.filter) != -1
					controller.selection.add person

			controller.view.display controller.selection
	#
	#
	#
	_fetchMembers: () ->
		@showLoader()
		blip = new Bolk.BlipRequest 'members'
		blip.request.always( ( data ) =>
			@hideLoader()
			if blip.result
				data = blip.result
				data = JSON.parse data if typeof data is String
				locache.async.set 'members-page', data, MembersPageController.CacheTime
				@_parseMembers data 
		)
		
	#
	#
	#
	_parseMembers: ( data ) ->
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
				
