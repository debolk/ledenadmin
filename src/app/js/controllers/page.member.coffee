# This is the controller class for the members listing pages. 
#
class Bolk.MemberPageController extends Bolk.PageController

	@CacheTime: 120

	#
	#
	#
	constructor: ( @uid ) ->
		super new Bolk.MemberPage( 'member-' + @uid )
		
		# Lets see if we have members data
		locache.async.get( 'member-page-' + @uid ).finished( ( data ) =>
			unless data
				@_fetchMember()
			else
				@_parseMember data
		)
		
	#
	#
	#
	_fetchMember: () ->
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
				@_parseMember data
			)
		)
		
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
		
				
