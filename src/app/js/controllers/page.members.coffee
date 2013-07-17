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
		@query = "membership:lid"
		
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
		@search.val @query
		@search.keyup ->
			filter = controller.search.val().toLowerCase()
			controller._filter filter
		@search.keypress ( event ) ->
			if event.keyCode = 13
				event.preventDefault()
				# Select first
				model = controller.selection.models[0];
				console.log model
				uid = model.attributes.uid
				window.location.hash = "/member/" + uid

	#
	#
	#
	_filter: (@query) ->
		if @query.length < 3
			@query = ""
			@view.display @model
			return

		@selection = new Bolk.Persons
		console.log @query
		for person in @model.models
			if person.matches @query
				@selection.add person

		@view.display @selection
	#
	#
	#
	_fetchMembers: () ->
		@showLoader()
		blip = new Bolk.BlipRequest 'persons'
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

		@_filter @query
		
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
				
