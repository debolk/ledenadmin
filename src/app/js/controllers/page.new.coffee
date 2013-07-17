# This is the controller class for the members listing pages. 
#
class Bolk.NewPageController extends Bolk.PageController

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
			controller.createMember data
			false
		
		@_parseMember {}

		$('input#search').attr('disabled','disabled')
		
	createMember: (data) ->
		controller = this

		api = "persons"
		blipdata = JSON.stringify data['input']['blip']
		blip = new Bolk.BlipRequest api, blipdata, 'POST'
		console.log blipdata
		blip.request.done (result) ->
			uid = result['uid']

			api = "person/#{uid}"
			operdata = data['input']['operculum']

			operdata['uid'] = uid
			operdata['alive'] = operdata['alive'] == "true";

			operdata = JSON.stringify operdata
			oper = new Bolk.OperculumRequest api, operdata, 'PUT'
			oper.request.done (result) ->
				console.log result
				window.location.hash = "/member/" + uid


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
		
				
