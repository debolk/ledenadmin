# This is the controller class for the members listing pages. 
#
class Bolk.MemberPageController extends Bolk.PageController

	@CacheTime: 120

	#
	#
	#
	constructor: ( @uid ) ->
		super new Bolk.MemberPage( 'member-' + @uid, @uid )

		# Define onSubmit callback
		controller = this
		@view.el.submit ->
			data = controller.view.el.serializeObject()
			controller.saveMember data
			false
		
		# Lets see if we have members data
		locache.async.get( 'member-page-' + @uid ).finished( ( data ) =>
			unless data
				@_fetchMember()
			else
				@_parseMember data
		)

		$('input#search').attr('disabled','disabled')
		
	#
	#
	#
	_fetchMember: (display = true) ->
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
				if(display)
					@_parseMember data
			)
		)
		
	saveMember: (data) ->
		controller = this

		api = "persons/#{@uid}"
		blipdata = JSON.stringify data['input']['blip']
		blip = new Bolk.BlipRequest api, blipdata, 'PATCH'
		console.log blipdata
		blip.request.done (result) ->
			console.log result
			controller._fetchMember false

		api = "person/#{@uid}"
		operdata = data['input']['operculum']

		operdata['uid'] = @uid
		operdata['alive'] = operdata['alive'] == "true";

		console.log operdata
		operdata = JSON.stringify operdata
		oper = new Bolk.OperculumRequest api, operdata, 'PUT'
		oper.request.done (result) ->
			console.log result
			controller._fetchMember false

	#
	#
	#
	_parseMember: ( data ) ->
		@model = new Bolk.Person( data )
		@view.display @model

	#
	#
	#
	_displayMember: ( model ) ->
		# create view from model
		
				
