# This is the controller class for the members listing pages. 
#
class Bolk.MemberPageController extends Bolk.PageController

	@CacheTime: 120

	# Creates a member page controller
	#
	# @param uid [String] the uid of the member
	#
	constructor: ( @uid, succes ) ->
		super new Bolk.MemberPage( 'member-' + @uid, @uid )

		# Define onSubmit callback
		@view.el.submit ( event ) =>
			event.preventDefault()
			@saveMember @view.el.serializeObject()
			false

		if succes
			@view.showSuccess("Aanmaken gelukt")
		
		# Lets see if we have members data
		locache.async.get( 'member-page-' + @uid ).finished( ( data ) =>
			unless data
				@_fetchMember()
			else
				@_parseMember data
		)

		$('input#search-field').prop( 'disabled', true )
		
	# Fetch member
	#
	# @param display [Boolean] displays the member
	# @return [self] the chainable self
	#
	_fetchMember: ( display = true ) ->
		blip = new Bolk.BlipRequest "persons/#{@uid}"
		blip.request.done( ( blipdata ) =>
			blipdata = JSON.parse blipdata if typeof blipdata is String
			
			# merge with operculum
			operculum = new Bolk.OperculumRequest "person/#{@uid}"
			operculum.request.always( ( operculumdata ) =>
				if operculumdata.error? and operculumdata.statusText? and operculumdata is "error"
					operculumdata = {}
				operculumdata = JSON.parse operculumdata if typeof operculumdata is String
				data = _.extend( operculumdata, blipdata, { complete : true } )
				locache.async.set 'member-page-' + @uid, data, MemberPageController.CacheTime
				@_parseMember data if display
			)
		)
		return this
		
	# Creates a request to save data to the blip endpoint
	#
	# @param data [Object] the form data
	# @return [Bolk.BlipRequest] the request
	#
	_createSaveBlipMemberRequest: ( data ) ->
		blipdata = JSON.stringify data['input']['blip']
		blip = new Bolk.BlipRequest "persons/#{@uid}", blipdata, 'PATCH'
		console.debug blipdata
		return blip
		
	# Creates a request to save data to the operculum endpoint
	#
	# @param data [Object] the form data
	# @return [Bolk.BlipRequest] the request
	#
	_createSaveOperculumMemberRequest: ( data ) ->
		operdata = data['input']['operculum']

		operdata['uid'] = @uid
		operdata['alive'] = operdata['alive'] is "true"
		
		operdata = JSON.stringify operdata
		oper = new Bolk.OperculumRequest "person/#{@uid}", operdata, 'PUT'
		console.debug operdata
		return oper
		
	# Save the member
	# 
	# @param data [Object] the member data
	# @return this [self] the chainable self
	#
	saveMember: ( data ) ->
		@view.clearErrors()
		progress = 0
		onDone = ( => 
			@_fetchMember false
			@view.showSuccess "Opslaan gelukt" if ++progress is 2  
		)
		
		# The blip request handling
		blip = @_createSaveBlipMemberRequest data
		blip.request.done onDone
		blip.request.fail ( error ) =>
			console.error "Error occurred on request #{ blip.statify() }", error
			@view.showError error.responseText

		# The operculum request handling
		oper = @_createSaveOperculumMemberRequest data
		oper.request.done onDone
		oper.request.fail ( error ) =>
			errors = error.responseJSON.error_description
			console.log errors
			@view.showError( message ) for message in errors

	# Parses the member and displays it
	#
	# @param data [Object] the member data
	# @return this [self] the chainable self
	#
	_parseMember: ( data ) ->
		@model = new Bolk.Person( data )
		@view.display @model
		return this
				
