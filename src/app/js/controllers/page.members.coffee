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
		@sortfield = "firstname"
				
		# Lets see if we have members data
		locache.async.get( 'members-page' ).finished( ( data ) =>
			unless data
				@_fetchMembers()
			else
				@_parseMembers data
		)

		# Bind to search form
		@_bindSearch()
		@_createExport()

	# Binds the search field
	#
	_bindSearch: () ->
		@search = $ '#search-field'
		@search.val @query
		
		@search.keyup _.debounce( ( => @processFilter() ), 400 )
			
		$( '#search' ).submit ( event ) =>
			event.preventDefault()
			@processFilter()
			model = @selection?[0]
			document.router.navigate "//member/#{ model.attributes.uid }", { trigger: true } if model?
			return false
			
	#
	#
	processFilter: ->
		filter = @search.val().toLowerCase()
		window.search_query = filter
		@_filter filter
		
	#
	#
	_createExport: () ->
		
		@exporter = $ '<a>export</a>'
		@exportcount = $ '<span></span>'
		$('.actions').append ' | '
		$('.actions').append @exporter
		$('.actions').append ' '
		$('.actions').append @exportcount
		
		@exporter.click =>
			return if @selection.length is 0
			
			@showLoader()
			
			actions = []
			for model in @selection
				action = model.merge_operculum() 
				actions.push action if action?
			
			$.when( actions... ).then () =>
				headers = []
				headers.push key for key, value of @selection[ 0 ].attributes
				
				result = headers.join( ',' ) + "\n"
				result += person.to_csv() + "\n" for person in @selection
				
				@hideLoader()
				
				data = 'data:text/csv,' + encodeURIComponent(result)
				window.location = data
			, () => console.error arguments
					
	# Filters on a query
	#
	# @param query [String] the query
	#
	_filter: ( @query ) ->
		@view.clearErrors()
		@selection = []
		if @query.length < 3
			@query = ""
			@selection = @model.models
			@view.display @model
			@showAllPersons()
			@exportcount.text '(' + @selection.length + ')'
			return this

		@hideAllPersons()
		branches = @query.split(' and ')
		tree = []
		
		branches = (part for part in branches when part.trim().length != 0)
		for branch in branches
			tree.push (leaf.trim().split(' ') for leaf in branch.split(' or ') when leaf.trim().length != 0)
		
		if @model?.models?
			for person in @model.models when person.matches( tree )
				@selection.push person
				@showPerson person.get 'uid' 
		
			if @selection.length is 0
				@view.showInfo 'Geen leden gevonden!'
		
		@exportcount.text '(' + @selection.length + ')'
		
		return this
		
	#
	#
	#
	showAllPersons: () ->
		$( '.members' ).children().css( 'display', 'inline-block' )
		return this
		
	hideAllPersons: () ->
		$( '.members' ).children().css( 'display', 'none' )
		return this
	
	#
	#
	#	
	hidePerson: ( uid ) ->
		$( "#person-#{ uid }" ).css( 'display', 'none' )
		return this
		
	showPerson: ( uid ) ->
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
		
		@sort()
		@view.display @model
		@_filter @query
		
	#
	#
	#
	sort: ( @sortfield = @sortfield ) ->
		@model.comparator = ( model ) => model.get( @sortfield ).toLowerCase()
		@model.sort()
		
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
				
