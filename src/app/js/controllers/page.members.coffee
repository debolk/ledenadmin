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
		if window.search_query == undefined
			@query = "membership:lid"
		else
			@query = window.search_query
		
		# Lets see if we have members data
		locache.async.get( 'members-page' ).finished( ( data ) =>
			#unless data
			@_fetchMembers()
			#else
			#	@_parseMembers data
		)

		# Bind to search form
		controller = this
		@search = $ 'input#search'
		@search.val @query
		@search.keyup ->
			filter = controller.search.val().toLowerCase()
			window.search_query = filter
			controller._filter filter
		@search.keypress ( event ) ->
			if event.keyCode == 13
				event.preventDefault()
				# Select first
				model = controller.selection.models[0];
				uid = model.attributes.uid
				window.location.hash = "/member/" + uid

		@export = $ '<a>export</a>';
		$('.actions').append(' | ');
		$('.actions').append(@export);
		@export.click ->
			for model in controller.selection.models
				model.merge_operculum () ->
					for model in controller.selection.models
						if !model.complete
							return

					header = ""
					first = true

					for key, value of controller.model.models[0].attributes
						header += "," unless first
						first = false

						header += key

					result = header + "\n"
					for person in controller.selection.models
						result += person.to_csv() + "\n"
						
					data = 'data:text/csv,' + encodeURIComponent(result)
					window.location =data;

	#
	#
	#
	_filter: (@query) ->
		if @query.length < 3
			@query = ""
			@selection = @model
			@view.display @model
			return

		tree = @query.split(' or ');
		tree = (part.split(' and ') for part in tree)

		@selection = new Bolk.Persons
		console.log tree
		for person in @model.models
			if person.matches tree
				@selection.add person

		@view.display @selection
	#
	#
	#
	_fetchMembers: () ->
		console.log 'HALLOO'
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
			person = new Bolk.Person( _.extend( person, { complete : false } ) )
			@model.add person

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
				
