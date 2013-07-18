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
		@query = window.search_query ? "membership:lid"
				
		# Lets see if we have members data
		locache.async.get( 'members-page' ).finished( ( data ) =>
			unless data
				@_fetchMembers()
			else
				@_parseMembers data
		)

		# Bind to search form
		@_bindSearch()

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

	# Binds the search field
	#
	_bindSearch: () ->
		@search = $ '#search-field'
		@search.val @query
		
		@search.keyup =>
			filter = @search.val().toLowerCase()
			window.search_query = filter
			@_filter filter
			
		$( '#search' ).submit ( event ) =>
			event.preventDefault()
			model = @selection.models[0]
			document.router.navigate "//member/#{ model.attributes.uid }", { trigger: true }
			return false
					
	# Filters on a query
	#
	# @param query [String] the query
	#
	_filter: ( @query ) ->
		@selection = []
		@hideAllPersons()
		if @query.length < 3
			@query = ""
			@selection = @model
			@view.display @model
			@showAllPersons()
			return this

		branches = @query.split(' and ')
		tree = []
		
		branches = (part for part in branches when part.trim().length != 0)

		for branch in branches
			tree.push (leaf.trim().split(' ') for leaf in branch.split(' or ') when leaf.trim().length != 0)

		for person in @model.models when person.matches( @tree )
			@selection.push person
			@showPerson person.get 'uid' 
			
		return this
		
	#
	#
	#
	showAllPersons: () ->
		$( '#members' ).children().css( 'display', 'inline-block' )
		return this
		
	hideAllPersons: () ->
		$( '#members' ).children().css( 'display', 'none' )
		return this
	
	#
	#
	#	
	hidePerson: ( uid ) ->
		console.log 'hide ' + uid
		$( "#person-#{ uid }" ).css( 'display', 'none' )
		return this
		
	showPerson: ( uid ) ->
		console.log 'show ' + uid
		$( "#person-#{ uid }" ).css( 'display', 'inline-block' )
		return this

	
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
			person = new Bolk.Person( _.extend( person, { complete : false } ) )
			@model.add person

		@view.display @model
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
				
